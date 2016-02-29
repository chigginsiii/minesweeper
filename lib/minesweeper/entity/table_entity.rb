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

		def get_cell(r, c)
			@table[(r - 1)][(c - 1)]
		end

		def put_cell(r, c, val)
			@table[r - 1][c - 1] = val
		end

		def empty_cell?(r, c)
			get_cell(r, c).nil?
		end

		private

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
				next unless empty_cell?(r, c)
				put_cell(r, c, Minesweeper::CellEntity.mine)
				break
			end
		end

		def fill_in_safe_cells
			(1..num_rows).each do |r|
				(1..num_cols).each do |c|
					next unless empty_cell?(r,c)
					put_cell(r, c, Minesweeper::CellEntity.safe)
				end
			end
		end
	end
end