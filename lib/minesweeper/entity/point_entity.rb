module Minesweeper
	class PointEntity
		attr_accessor :row, :col
		def initialize(row:, col:)
			@row = row
			@col = col
		end

		def == (arg)
			self.row == arg.row && self.col == arg.col
		end

		def to_s
			"#{@row}:#{col}"
		end
		alias_method :coords, :to_s

		def get_cell(board)
			board[row - 1][col - 1]
		end

		def put_cell(board, val)
			board[row - 1][col - 1] = val
		end
	end

	class PositionEntity < PointEntity
		attr_reader :row, :col
		def initialize(row:, col:, rows:, cols:)
			@rows = rows
			@cols = cols
			super(row: row, col: col)
		end

		def up 
			@row -= 1 unless @row <= 1
		end

		def down
		  @row += 1 unless @row >= @rows
		end

		def left
		  @col -= 1 unless @col <= 1
		end

		def right
		  @col += 1 unless @col >= @cols
		end

	end
end