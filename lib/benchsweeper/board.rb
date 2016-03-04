module Benchsweeper
	class Board
		def initialize(game)
			@game = game
			setup
		end

		def setup
			@board = []
			@game.flat_board.split("\n").each_with_index do |row, row_i|
				board_row = []
				row.split('').each_with_index do |val, col_i|
					board_row << Cell.new(val, row_i, col_i)
				end
				@board << row
			end
		end

		def all_cells
			@board.flatten
		end

		def get_cell(row, col)
			return unless valid_row_col row, col
			@board[row - 1][col - 1]
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

		def valid_row_col(r,c)
			row > 0 && row <= @board.length && col > 0 && col <= @board[0].length
		end
	end
end