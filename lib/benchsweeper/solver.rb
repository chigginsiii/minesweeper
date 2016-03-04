	module Benchsweeper
		class Solver
		attr_reader

		def initialize(game)
			@game = game
			@board = Board.new game
		end

		def complete?
			@game.complete?
		end

		# find cells where hidden adjacent == num adjacent
		# test whole board, restart the loop if it succeeds (100%)
		def fill_in_blocks
			puts 'fill in blocks'
			num_changed = 0
		end

		# find cells where num adjacent == hidden + flagged
		# test first avail, stop as soon as one succeeds
		def fill_in_flag_blocks
			puts 'fill in flag blocks'
			num_changed = 0
		end

		# find a cell with the lowest num adjacents and most hidden/flagged,
		# pick an adjacent hidden at random
		# test best criteria, return as soon as one's been done
		def pick_random_adjacent
			puts 'select random adjacent'
			num_changed = 0
		end

		# and here we are. find a hidden cell and pick it. heh.
		# return immediately
		def pick_random
			puts 'select random'
			puts @game.flat_board
			@game.complete(:won)
			num_changed = 0
		end

		private
	end
end

=begin
PICKING A SQUARE
- to GAME: "need a board with cells, represented perhaps as an array of arrays?"
- ME: iterate over squares, selecting those that meet criteria
- to GAME:
  - select position (r, c)
  - flag position (r, c)
- to GAME: 'complete?'
	  Y -> this one is over, record result and do it again
	  N -> not complete, return
=end