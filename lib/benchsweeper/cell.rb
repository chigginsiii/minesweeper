module Benchsweeper
	class Cell
		attr_reader :value, :row, :col
		def initialize(val, row_i, col_i)
			@value = val
			@row   = row_i + 1
			@col   = col_i + 1
		end

		def status
			@status ||= case value
			when 'F'
				:flag
			when 'M'
				:mine
			when /^(\d|\.)$/
				:revealed
			else
				:hidden
			end
		end

		def adjacent_mines
			value == '.' ? 0 : cell.to_i
		end

		def hidden?
			status == :hidden
		end

		def flagged?
			status == :flag
		end

		def mine?
			status == :mine
		end

		def revealed?
			status == :revealed
		end

		def coords
			"#{row}:#{col}"
		end
	end
end