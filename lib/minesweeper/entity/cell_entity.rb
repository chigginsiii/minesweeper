module Minesweeper
	class CellEntity
		extend Forwardable
		attr_accessor :point
		def_delegators :@point, :row, :col

		class << self
			def mine(point:)
				self.new(mine: true, point: point)
			end

			def safe(point:)
				self.new(point: point)
			end
		end

		def initialize (point:, mine: false)
			@point 					= point
			@mine     			= mine
			@flagged  			= false
			@revealed 			= false
		end

		#
		# state queries
		#

		def mine?
			# return nil until revealed?
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

		# debug

		def status
			s = mine? ? 'M' : '-'
			s += revealed? ? 'r' : flagged? ? 'f' : 'h'
		end
	end
end