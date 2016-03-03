module Minesweeper
	class GameEntity
		extend Forwardable

		attr_reader :board, :status, :renderer, :position

		def_delegators :@board, :num_rows, :num_cols, :num_mines, :flagged_cells  
		def_delegators :@renderer, :draw

		#
		# set_status  -> real game status
		# command dispatch:, gather common housekeeping functions, call use_cases
		# what are the real game states? start with: [inprog, won, lost]
		# 
		# api: game.status in [ in_progress, complete ]
		# 		 game.result in [ won, lost ]
		# 		 game.board (fka: board)
		#

		def initialize (rows:, cols:, mines:)
			@position = PositionEntity.new(row: 1, col: 1, rows: rows, cols: cols)
			@board 		= BoardEntity.new(rows, cols, mines)
			@renderer = Render.new(self)
			@status 	= StatusEntity.new

			status.begin
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

		private

		def check_for_winner
			return if status.lost?
			all_cells = board.all_cells.count
			revealed_cells = board.revealed_cells.count
			num_mines = board.num_mines

			write_flash_msg "all: #{all_cells} revealed: #{revealed_cells} mines: #{num_mines}"

			# num mines should equal total cells minus total hidden
			if all_cells == revealed_cells + num_mines
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
				board.reveal_all_cells
			else
				if board.adjacent_mines(cell).count == 0
					board.reveal_adjacent_cells cell
				end
			end
		end
	end
end
