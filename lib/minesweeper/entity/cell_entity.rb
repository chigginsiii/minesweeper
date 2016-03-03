module Minesweeper
	class CellEntity
		class << self
			def mine(row:, col:, table:)
				self.new(mine: true, row: row, col: col, table: table)
			end

			def safe(row:, col:, table:)
				self.new(row: row, col: col, table: table)
			end
		end

		attr_reader :row, :col

		def initialize (row:, col:, table:, mine: false)
			@table    			= table
			@row      			= row
			@col      			= col
			@mine     			= mine
			@flagged  			= false
			@revealed 			= false
		end

		#
		# XXX: these belong in table.
		#

		def adjacent_cells
			@adjacent_cells ||= @table.adjacent_cells(self)
		end

		def adjacent_mines
			@adjacent_mines ||= adjacent_cells.select {|a_cell| a_cell.mine? }
		end

		#
		# state queries
		#

		def mine?
			@mine == true
		end

		def reveal!
			@flagged = false
			@revealed = true
		end

		def revealed?
			@revealed == true
		end

		def hidden?
			!revealed?
		end

		def flagged?
			@flagged == true
		end

		def unflagged?
			!flagged?
		end

		#
		# state commands
		#

		def reveal
			raise Minesweeper::SelectError, 'cannot reveal flagged cell' if flagged?
			reveal!
		end

		def toggle_flag
			raise Minesweeper::SelectError, 'revealed cell cannot be flagged' if revealed?
			@flagged = !@flagged
		end

		# these should be an object

		def coords
			[row, col]
		end

		# debug

		def status
			s = mine? ? 'M' : '-'
			s += revealed? ? 'r' : flagged? ? 'f' : 'h'
		end
	end
end