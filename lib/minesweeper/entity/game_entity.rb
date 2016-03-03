module Minesweeper
	class GameEntity
		extend Forwardable

		attr_reader :table, :status, :renderer, :position

		def_delegators :@table, :num_rows, :num_cols, :num_mines, :flagged_cells  
		def_delegators :@renderer, :draw

		#
		# set_status  -> real game status
		# command dispatch:, gather common housekeeping functions, call use_cases
		# what are the real game states? start with: [inprog, won, lost]
		# 
		# api: game.status in [ in_progress, complete ]
		# 		 game.result in [ won, lost ]
		# 		 game.board (fka: table)
		#

		def initialize (rows:, cols:, mines:)
			@position = PositionEntity.new(row: 1, col: 1)
			@table 		= TableEntity.new(rows, cols, mines)
			@renderer = Minesweeper::Render.new(self)
			@status 	= StatusEntity.new
		end

		def dispatch_action(action, *opts)
			# when this is complete, we've either won or lost
			return unless status.in_progress?
			case action
			when :move
				move opts[0]
			when :toggle
				toggle_flag
			when :reveal
				reveal_cell
			end
			check_for_winner
			# and then rescue the mine to make it a loss
		end

		private

		def check_for_winner
			# was this a loss? (bomb)
			# was this a win? (uncovered = cells - bombs)
			# continue
		end

		def move(dir)
			position.move(dir)
		end

		# use case. yep.

		def toggle_flag
			cell = table.get_cell(position)
			cell.toggle_flag
		rescue SelectError
			set_flash_msg "can't flag revealed cell"
		end

		# ditto.

		def reveal_cell
			cell = table.get_cell(position)
			return if cell.revealed?
			cell.reveal
			handle_reveal cell
		rescue SelectError
			write_flash_message "can't reveal flagged cell" # except on your first move... grrr.		
		end

		def handle_reveal(cell)
			if cell.mine?
				status.complete.lose
				table.reveal_all_cells
			else
				if cell.adjacent_mines.count == 0
					table.reveal_adjacent_cells cell
				end
			end
		end

		def write_flash_msg(msg)
			@flash_message = msg
		end

		def read_flash_msg
			retval = @flash_message
			@flash_message = ''
			retval
		end
	end
end
