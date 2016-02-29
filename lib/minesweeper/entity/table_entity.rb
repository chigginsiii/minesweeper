module Minesweeper
	class TableEntity
		attr_reader :rows, :cols, :mines

		# XXX: move to config when configs available
		MaxRows = 50
		MaxCols = 50

		def initialize(rows:, cols:, mines: )
			@rows = rows
			@cols = cols
			@mines = mines
			validate_params
			setup
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
			raise Minesweeper::TableError, 'invalid number of rows' unless rows && rows.between?(1, MaxRows)
		end

		def validate_cols
			raise Minesweeper::TableError, 'invalid number of cols' unless cols && cols.between?(1, MaxCols)
		end

		def validate_mines
			raise Minesweeper::TableError, 'invalid number of mines' unless mines && mines <= (rows * cols)
		end

		#
		# table setup
		#

		def setup
			# create a column in each of the rows
			(0...rows).each {|i| table_rows[i] = create_column }
		end

		def create_column
			Array.new(cols)
		end

		def table_rows
			@table_rows ||= []
		end

	end
end