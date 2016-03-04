module Minesweeper
	class BoardEntity
		attr_reader :num_rows, :num_cols, :num_mines

		# XXX: move to config when configs available
		MaxRows = 50
		MaxCols = 50

		def initialize(rows, cols, mines )
			@num_rows  = rows
			@num_cols  = cols
			@num_mines = mines
			validate_params
			setup
		end

		def board
			@board ||= Array.new(num_rows) { Array.new(num_cols) }
		end

		def get_cell(point)
			point.get_cell board
		end

		def put_cell(cell)
			cell.point.put_cell board, cell
		end

		def empty_cell?(point)
			get_cell(point).nil?
		end

		#
		# scopes/queries
		#

		def all_cells
			@board.flatten
		end

		def hidden_cells
			all_cells.select {|c| c.hidden? }
		end

		def revealed_cells
			all_cells.select {|c| c.revealed? }
		end

		def flagged_cells
			all_cells.select {|c| c.flagged? }
		end

		def adjacent_cells(cell)
			adjacent_cell_points(cell).map{|a_cell_point| get_cell(a_cell_point) }
		end

		def adjacent_mines(cell)
			adjacent_cells(cell).select {|c| c.mine? }
		end

		#
		# action: reveal the whole board
		#

		def reveal_all_cells
			all_cells.each {|c| c.reveal! }
		end

		#
		# action: reveal all the adjacent cells
		#
		# NOTE: in the original, you can flag your first cell, then if it's a non-touching
		# cell inside a bunch of others, it status flagged until you unflag it, but then
		# you can't unflag it again.
		#
		# that's a case that needs more thought. v2 perhaps.
		#

		def reveal_adjacent_cells(cell)
			adjacent_cells(cell)
			  .select {|a_cell| a_cell.hidden? }
			  .each do |this_cell|
					this_cell.reveal!
					if adjacent_mines(this_cell).count == 0
						reveal_adjacent_cells this_cell
					end
				end
		end

		private

		#
		# adjacent_cells helpers
		#

		def adjacent_cell_points(cell)
			top_row, middle_row, bottom_row = cell.row() - 1, cell.row(), cell.row() + 1
			left_col, center_col, right_col = cell.col() -1 , cell.col(), cell.col() + 1

			[
				[top_row, left_col],
				[top_row, center_col],
				[top_row, right_col],
			 	[middle_row, left_col],
			 	[middle_row, right_col],
			 	[bottom_row, left_col],
			 	[bottom_row, center_col],
			 	[bottom_row, right_col]
			]
				.map {|rc| PointEntity.new(row: rc[0], col: rc[1])}
				.select {|point| row_exists(point) && col_exists(point) }
		end

		def row_exists(point)
			point.row >= 1 && point.row <= @board.length
		end

		def col_exists(point)
			point.col >= 1 && point.col <= @board[0].length
		end

		#
		# param validation
		#

		def validate_params
			validate_rows
			validate_cols
			validate_mines
		end

		def validate_rows
			raise Minesweeper::BoardError, "invalid number of rows (#{@num_rows})" unless @num_rows && @num_rows > 0 && @num_rows <= MaxRows
		end

		def validate_cols
			raise Minesweeper::BoardError,  "invalid number of cols (#{@num_cols})" unless @num_cols && @num_cols > 0 && @num_cols <= MaxCols
		end

		def validate_mines
			raise Minesweeper::BoardError, "invalid number of mines (#{@num_mines})" unless @num_mines && @num_mines <= @num_rows * @num_cols
		end

		#
		# board setup
		#

		def setup
			board
			place_mines
			fill_in_safe_cells
		end

		def place_mines
			num_mines.times { place_mine }
		end

		def place_mine
			loop do
				r = (1..num_rows).to_a.sample
				c = (1..num_cols).to_a.sample
				random_point = PointEntity.new(row: r, col: c)
				next unless empty_cell? random_point
				put_cell(Minesweeper::CellEntity.mine point: random_point)
				break
			end
		end

		def fill_in_safe_cells
			(1..num_rows).each do |r|
				(1..num_cols).each do |c|
					point = PointEntity.new(row: r, col: c)
					next unless empty_cell? point
					put_cell(Minesweeper::CellEntity.safe point: point)
				end
			end
		end
	end
end