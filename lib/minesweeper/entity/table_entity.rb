module Minesweeper
	class TableEntity
		attr_reader :num_rows, :num_cols, :num_mines

		# XXX: move to config when configs available
		MaxRows = 50
		MaxCols = 50

		def initialize(rows, cols, mines )
			@num_rows = rows
			@num_cols = cols
			@num_mines = mines
			validate_params
			setup
		end

		def get_cell(row:, col:)
			@table[(row - 1)][(col - 1)]
		end

		def put_cell(cell)
			@table[cell.row - 1][cell.col - 1] = cell
		end

		def empty_cell?(row:, col:)
			get_cell(row: row, col: col).nil?
		end

		def adjacent_cells(cell)
			adjacent_cell_coords(cell).map{|coords| get_cell(row: coords[0], col: coords[1]) }
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
			raise Minesweeper::TableError, 'invalid number of rows' unless num_rows && num_rows.between?(1, MaxRows)
		end

		def validate_cols
			raise Minesweeper::TableError, 'invalid number of cols' unless num_cols && num_cols.between?(1, MaxCols)
		end

		def validate_mines
			raise Minesweeper::TableError, 'invalid number of mines' unless num_mines && num_mines <= (num_rows * num_cols)
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
				r, c = rand(num_rows), rand(num_cols)
				next unless empty_cell?(row: r, col: c)
				put_cell(Minesweeper::CellEntity.mine row: r, col: c)
				break
			end
		end

		def fill_in_safe_cells
			(1..num_rows).each do |r|
				(1..num_cols).each do |c|
					next unless empty_cell?(row: r, col: c)
					put_cell(Minesweeper::CellEntity.safe row: r, col: c)
				end
			end
		end
	end
end