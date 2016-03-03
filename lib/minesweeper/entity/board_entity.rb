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

		def get_cell(coord)
			coord.get_cell @board
		end

		def put_cell(cell)
			coord.put_cell @board, cell
		end

		def empty_cell?(row:, col:)
			get_cell(row: row, col: col).nil?
		end

		#
		# scopes/queries
		#

		def all_cells
			@table.flatten
		end

		def hidden_cells
			all_cells.select {|c| c.hidden? }
		end

		def flagged_cells
			all_cells.select {|c| c.flagged? }
		end

		def adjacent_cells(cell)
			adjacent_cell_coords(cell).map{|coords| get_cell(row: coords[0], col: coords[1]) }
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
					if this_cell.adjacent_mines.count == 0
						reveal_adjacent_cells this_cell
					end
				end
		end

		private

		#
		# adjacent_cells helpers
		#

		def adjacent_cell_coords(cell)
			top_row, middle_row, bottom_row = cell.row() - 1, cell.row(), cell.row() + 1
			left_col, center_col, right_col = cell.col() -1 , cell.col(), cell.col() + 1
			[
				[top_row, left_col], 		[top_row, center_col], 		[top_row, right_col],
			 	[middle_row, left_col],                     			[middle_row, right_col],
			 	[bottom_row, left_col], [bottom_row, center_col], [bottom_row,right_col]
			].select do |coords|
				row_exists(coords[0]) && col_exists(coords[1])
			end
		end

		def row_exists(row)
			row >= 1 && row <= @table.length
		end

		def col_exists(col)
			col >= 1 && col <= @table[0].length
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
			raise Minesweeper::TableError, "invalid number of rows (#{@num_rows})" unless @num_rows && @num_rows > 0 && @num_rows <= MaxRows
		end

		def validate_cols
			raise Minesweeper::TableError,  "invalid number of cols (#{@num_cols})" unless @num_cols && @num_cols > 0 && @num_cols <= MaxCols
		end

		def validate_mines
			raise Minesweeper::TableError, "invalid number of mines (#{@num_mines})" unless @num_mines && @num_mines <= @num_rows * @num_cols
		end

		#
		# table setup
		#

		def setup
			create_table
			place_mines
			fill_in_safe_cells
		end

		def create_table
			@table = Array.new(num_rows) { Array.new(num_cols) }
		end

		def place_mines
			num_mines.times { place_mine }
		end

		def place_mine
			loop do
				r = (1..num_rows).to_a.sample
				c = (1..num_cols).to_a.sample
				next unless empty_cell?(row: r, col: c)
				put_cell(Minesweeper::CellEntity.mine row: r, col: c, table: self)
				break
			end
		end

		def fill_in_safe_cells
			(1..num_rows).each do |r|
				(1..num_cols).each do |c|
					next unless empty_cell?(row: r, col: c)
					put_cell(Minesweeper::CellEntity.safe row: r, col: c, table: self)
				end
			end
		end
	end
end