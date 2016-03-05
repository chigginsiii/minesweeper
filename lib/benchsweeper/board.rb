module Benchsweeper
	class Board
		attr_reader :game

		def initialize(game)
			@game = game
			setup
		end

		def board
			@board ||= []
		end

		def all_cells
			board.flatten
		end

		def hidden_cells
			all_cells.select {|c| c.hidden? }
		end

		def revealed_cells
			all_cells.select {|c| c.revealed? }
		end

		def get_cell(row, col)
			return unless valid_row_col row, col
			board[row - 1][col - 1]
		end

		def adjacent_cells(cell)
			adjacent = []
			[cell.row - 1, cell.row, cell.row + 1].each do |r|
				[cell.col - 1, cell.col, cell.col + 1].each do |c|
					next if cell.row == r && cell.col == c
					next unless a_cell = get_cell(r, c)
					adjacent << a_cell
				end
			end
			adjacent
		end

		private

		def setup
			game.flat_board.split("\n").each_with_index do |row, row_i|
				board_row = []
				# unicode splits are hard.
				row
					.split('')
					.reject {|char| char =~ /[[:space:]]/ }
					.each_with_index do |val, col_i|
						board_row << Cell.new(val, row_i, col_i)
					end
				board << board_row
			end
		end

		def valid_row_col(row, col)
			row > 0 && row <= board.length && col > 0 && col <= board[0].length
		end
	end
end