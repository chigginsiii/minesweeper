module Minesweeper
	class Game
		extend Forwardable

		#
		# XXX: concepts list 'position' and 'move' are cursor concepts,
		# they belong in a UI class to wire the game's API to a terminal client.
		#

		attr_reader :board, :status, :renderer, :position, :stats

		def_delegators :@board, :num_rows, :num_cols, :num_mines, :flagged_cells  
		def_delegators :@renderer, :draw
		def_delegators :@status, :complete?, :in_progress?, :won?, :lost?, :complete

		def initialize (rows:, cols:, mines:)
			@position = PositionEntity.new(row: 1, col: 1, rows: rows, cols: cols)
			@board 		= BoardEntity.new(rows, cols, mines)
			@renderer = Render.new(self)
			@status 	= StatusEntity.new
			@stats    = StatsEntity.new(self)
			write_flash_msg "Good Luck!"
		end

		#
		# api: generalize actions here, and
		#      then refactor UI-coupled methods
		#      to use them.
		#

		def select_cell(row:, col:)
			point = PointEntity.new(row: row, col: col)
			cell = board.get_cell point
			return if cell.revealed?

			cell.reveal
			handle_revealed cell unless complete?
			check_for_completion
		rescue SelectError
			# do nothing if we selected a flagged cell
		end


		def flag_cell(row:, col:)
			cell = board.get_cell PointEntity.new(row: row, col: col)
			cell.flag unless cell.revealed?
		end

		def unflag_cell(row:, col:)
			cell = board.get_cell point PointEntity.new(row: row, col: col)
			cell.toggle_flag if cell.flagged?
		end

		def flat_board
			Minesweeper::RenderFlat.new(self).draw
		end


		# XXX: privatize once UI's are extracted.
		def handle_revealed(cell)
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

		#
		# XXX: extract to UI class
		#

		def dispatch_action(action, *opts)
			return if status.complete?

			case action
			when :move
				move opts[0]
			when :toggle
				toggle_flag
			when :reveal
				reveal_cell
			end
			check_for_winner
		end

		def write_flash_msg(msg)
			@flash_message = msg
		end

		def read_flash_msg
			retval = @flash_message
			@flash_message = ''
			retval
		end
		private

		def check_for_winner
			return if status.lost?
			# num mines should equal total cells minus total hidden
			if stats.cells_total == stats.cells_revealed + stats.mines
				status.complete :won
				write_flash_msg "YOU WON!"
			end
		end

		#
		# XXX: these are mostly coupled to terminal UI responsibilities
		# and need to have UI elements extracted from game API.
		#

		def move(dir)
			position.send(dir)
		end

		def toggle_flag
			cell = board.get_cell(position)
			cell.toggle_flag
		rescue SelectError
			set_flash_msg "can't flag revealed cell"
		end

		# ditto.

		def reveal_cell
			cell = board.get_cell(position)
			return if cell.revealed?
			cell.reveal
			handle_reveal cell
		rescue SelectError
			write_flash_msg "can't reveal flagged cell" # except on your first move... grrr.		
		end

		def handle_reveal(cell)
			if cell.mine?
				status.complete :lost
				write_flash_msg "YOU LOSE!"
				@renderer = RenderHidden.new(self)
			else
				if board.adjacent_mines(cell).count == 0
					board.reveal_adjacent_cells cell
				end
			end
		end
	end
end
