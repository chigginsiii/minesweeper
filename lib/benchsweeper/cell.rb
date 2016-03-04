module Benchsweeper
	class Cell
		attr_reader :value, :row, :col
		def initialize(val, row_i, col_i)
			@value = val
			@row = row_i + 1
			@col = col_i + 1
		end

		def status
			case value
			when 'F'
				:flag
			when 'M'
				:mine
			when '◼'
				:hidden
			else
				:safe
			end
		end

		def adjacent_mines
			value == '.' ? 0 : cell.to_i
		end
	end
end