module Minesweeper
	class CellEntity

		class << self
			def mine(row:, col:)
				self.new(mine: true, row: row, col: col)
			end

			def safe(row:, col:)
				self.new(row: row, col: col)
			end
		end

		attr_reader :row, :col

		def initialize (row:, col:, mine: false)
			@row      = row
			@col      = col
			@mine     = mine
			@flagged  = false
			@revealed = false
		end

		def mine?
			@mine == true
		end

		def reveal
			raise Minesweeper::SelectError, 'cannot reveal flagged cell' if flagged?
			@revealed = true
		end

		def revealed?
			@revealed == true
		end

		def toggle_flag
			raise Minesweeper::SelectError, 'revealed cell cannot be flagged' if revealed?
			@flagged = !@flagged
		end

		def flagged?
			@flagged == true
		end

	end
end