module Minesweeper
	class Game
		extend Forwardable

		#
		# XXX: concepts list 'position' and 'move' are cursor concepts,
		# they belong in a UI class to wire the game's API to a terminal client.
		#

		attr_reader :board, :status, :position, :stats

		def_delegators :@board, :num_rows, :num_cols, :num_mines, :flagged_cells  
		def_delegators :@status, :complete?, :in_progress?, :won?, :lost?, :complete

		def initialize (rows:, cols:, mines:)
			@board 		= BoardEntity.new(rows, cols, mines)
			@status 	= StatusEntity.new
			@stats    = StatsEntity.new(self)
		end

		#
		# api: generalize actions here, and
		#      then refactor UI-coupled methods
		#      to use them.
		#

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
			Minesweeper::Render.new(self).draw
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

		# ditto.
	end
end
