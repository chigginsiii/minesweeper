module Minesweeper
	class StatsEntity
		attr_reader :game, :board, :status
		def initialize(game)
			@game = game
			@board = game.board
			@status = game.status
		end

		def cells_total
			board.all_cells.count
		end

		def cells_revealed
			board.revealed_cells.count
		end

		def cells_flagged
			board.flagged_cells.count
		end

		def mines
			board.num_mines.to_i
		end

		def to_s
			if status.in_progress?
				"revealed/mines/total: #{cells_revealed}/#{mines}/#{cells_total}"
			elsif status.won?
				"WINNER!"
			else
				"GAME OVER!"
			end
		end
	end
end
