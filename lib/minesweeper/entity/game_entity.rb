module Minesweeper
	class GameEntity
		extend Forwardable

		#
		# lotsa things to refactor here, "entity" has been stretched.
		# most of the commands would be better migrated to use-cases,
		# and 'Game' is closer to an gateway/controller by now.
		#
		# Additionallly, concepts list 'position' and 'move' are cursor concepts,
		# they belong in a UI class to wire the game's API to a terminal client.
		#
		# but what the hell, the glue's gotta go somewhere. today it goes here.
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

		def flat_board
			Minesweeper::RenderArray.new(self).draw
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

		def move(dir)
			position.send(dir)
		end

		# use case. yep.

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
