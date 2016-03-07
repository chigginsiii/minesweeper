module Minesweeper
	class Game
		extend Forwardable

		#
		# these should perhaps be protected or private...
		# but it's sure handy for testing heh.
		#
		attr_reader :board, :status, :position, :stats

		def_delegators :@board, :num_rows, :num_cols, :num_mines  
		def_delegators :@status, :complete?, :in_progress?, :won?, :lost?, :complete

		def initialize (rows:, cols:, mines:)
			@board 		= BoardEntity.new(rows, cols, mines)
			@status 	= StatusEntity.new
			@stats    = StatsEntity.new(self)
		end

		def select_cell(row:, col:)
			point = PointEntity.new(row: row, col: col)
			cell = board.get_cell point
			return if cell.revealed? && cell.flagged?

			reveal_cell cell
			check_for_completion
		end

		def toggle_flag(row:, col:)
			cell = board.get_cell PointEntity.new(row: row, col: col)
			cell.flagged? ? cell.unflag : cell.flag
		end

		def flag_cell(row:, col:)
			cell = board.get_cell PointEntity.new(row: row, col: col)
			cell.flag unless cell.revealed?
		end

		def unflag_cell(row:, col:)
			cell = board.get_cell point PointEntity.new(row: row, col: col)
			cell.unflag
		end

		def flat_board
			Render.new(self).draw
		end

		def flat_board_revealed
			RenderHidden.new(self).draw
		end

		private

		def reveal_cell(cell)
			cell.reveal
			# reveal adjacents if this cell isn't touching
			if board.adjacent_mines(cell).count == 0
				board.reveal_adjacent_cells cell
			end
		end

		def check_for_completion
			if revealed_mine?
				status.complete :lost
			elsif stats.cells_revealed == stats.cells_total - stats.mines
				status.complete :won
			end
		end

		def revealed_mine?
			board.revealed_cells.find {|c| c.mine? }.nil? ? false : true
		end
	end
end
