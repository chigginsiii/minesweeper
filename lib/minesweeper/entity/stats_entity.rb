module Minesweeper
	class StatsEntity
		attr_reader :game
		def initialize(game)
			@game = game
		end

		def cells_total
			game.board.all_cells.count
		end

		def cells_revealed
			game.board.revealed_cells.count
		end

		def cells_flagged
			game.board.flagged_cells.count
		end

		def mines
			game.board.num_mines
		end

		def to_s
			if game.status.in_progress?
				"mines/flags: #{mines}/#{cells_flagged}"
			elsif game.status.won?
				"WINNER!"
			else
				"GAME OVER!"
			end
		end
	end
end
