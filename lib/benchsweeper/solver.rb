module Benchsweeper
	class Solver
		extend Forwardable
		attr_reader :game, :board

		def initialize(game)
			@game = game
			update_board
		end

		def complete?
			game.complete?
		end
		#
		# each of these solver methods returns true if cells
		# have been changed, false if they have not.
		#

		#
		# these are all ripe for refactoring now. the duplication is pretty evident,
		# the pattern's emerged, and the abstraction is understood.
		#

		#   where: num_touching equals number of hidden + flagged adjacent squares
		#       -> flag those hidden squares
		def must_be_mines
			cells_to_flag = {}
			board.revealed_cells.each do |cell|
				hidden_or_flagged_adjacents = board.adjacent_cells(cell).select {|ac| ac.hidden? || ac.flagged?}
				if cell.value.to_i == hidden_or_flagged_adjacents.count
					hidden_or_flagged_adjacents.each { |ac| cells_to_flag[ac.coords] = ac unless ac.flagged?}
				end
			end
			return false if cells_to_flag.empty?

			cells_to_flag.each_value do |c|
			  game.flag_cell(row: c.row, col: c.col)
			end
			update_board
			true
		end

		#   where: num_touching equals number of flagged squares
		#       -> reveal those hidden sqares
		def must_not_be_mines
			cells_to_reveal = {}
			board.revealed_cells.each do |cell|
				flagged_adjacents = []
				hidden_adjacents = []
				board.adjacent_cells(cell).each do |ac| 
					flagged_adjacents << ac if ac.flagged?
					hidden_adjacents << ac if ac.hidden?
				end
				next if flagged_adjacents.empty? || hidden_adjacents.empty?

				if cell.value.to_i == flagged_adjacents.count
					hidden_adjacents.each { |ac| cells_to_reveal[ac.coords] = ac }
				end
			end
			return false if cells_to_reveal.empty?

			cells_to_reveal.each_value do |c|
			  game.select_cell(row: c.row, col: c.col)
			end
			update_board
			true
		end


		def pick_random_adjacent
			# get a cell with a low adjacent-mines value
			ordered_revealed_cells = board
				.revealed_cells
				.select {|c| c.value =~ /^[1-8]$/ }
				.sort_by {|c| c.value }
			return false if ordered_revealed_cells.empty?

			# find the first hidden adjacent cell that comes our way...
			adjacent_hidden_cell = nil
			ordered_revealed_cells.each do |c|
			  adjacent_hidden_cell = board.adjacent_cells(c).find {|ac| ac.hidden? }
			  break unless adjacent_hidden_cell.nil?
			end
			return false if adjacent_hidden_cell.nil?

			game.select_cell(
				row: adjacent_hidden_cell.row,
				col: adjacent_hidden_cell.col
			)
			update_board
			true
		end

		# and here we are. find a hidden cell and pick it. heh.
		def pick_random
			random = board.hidden_cells.sample
			game.select_cell( row: random.row, col: random.col)
			update_board
			true
		end

		private

		# guarantees a new board each 
		def update_board
			@board = Board.new game
		end

	end
end
