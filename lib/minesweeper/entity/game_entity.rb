module Minesweeper
	class GameEntity
		extend Forwardable

		attr_reader :table, :last_action, :status
		attr_accessor :position

		def_delegators :@table, :num_rows, :num_cols, :num_mines
		def_delegators :@renderer, :draw, :draw_revealed

		DefaultRows 	= 10
		DefaultCols 	= 12
		DefaultMines 	= 20

		def initialize (rows: DefaultRows, cols: DefaultCols, mines: DefaultMines)
			@position = [1,1]
			@table = Minesweeper::TableEntity.new(rows, cols, mines)
			@renderer = Minesweeper::Render.new(self)
			set_last_action "initialized game"
			set_status "Good Luck!"
		end

		def set_last_action(msg='')
			@last_action = msg
		end

		def set_status(status = '')
			@status = status
		end

		#
		# the logic in here is becoming less organized, more coupled and !DRY.
		# probably a cmd dispatcher to handle common status/win checks and some
		# serious refactoring of conditional branches is in order.
		#
		# it may also be about (past) time to pull the logic out of the entities
		# and to put it into use cases. Repos aren't necessary yet.
		#

		def move(dir)
			set_status
			prev = @position.to_s
			case dir
			when :up
				@position[0] -= 1 unless @position[0] <= 1
			when :down
				@position[0] += 1 unless @position[0] >= num_rows
			when :left
				@position[1] -= 1 unless @position[1] <= 1
			when :right
  			@position[1] += 1 unless @position[1] >= num_cols
  		end
  		set_last_action "moved from #{prev} to #{@position.to_s}"
		end

		def toggle_flag
			set_status
			cell = table.get_cell(row: @position[0], col: @position[1])
			cell.toggle_flag
			check_for_winner
		rescue SelectError
			set_status "can't flag revealed cell"
		ensure
			set_last_action "flag #{cell.coords}"
		end

		def reveal_cell
			set_status
			cell = table.get_cell(row: @position[0], col: @position[1])
			return if cell.revealed?
			cell.reveal
			handle_reveal cell
		rescue SelectError
			set_status "can't reveal flagged cell" # except on your first move... grrr.		
		ensure
			set_last_action "reveal #{cell.coords}"
		end

		def handle_reveal(cell)
			if cell.mine?
				set_status "BOOM"
				table.reveal_all_cells
			else
				if cell.adjacent_mines.count == 0
					table.reveal_adjacent_cells cell
				end
				check_for_winner
			end
		end

		def check_for_winner
			if table.flagged_cells.count == num_mines
				set_status "WIN!"
			end
		end
	end
end
