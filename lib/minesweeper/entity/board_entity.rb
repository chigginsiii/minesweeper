module Minesweeper
	class BoardEntity
		extend Forwardable
		def_delegators :@table, :num_rows, :num_cols, :num_mines
		def_delegators :@renderer, :draw, :draw_revealed

		DefaultRows 	= 6
		DefaultCols 	= 4
		DefaultMines 	= 10

		def initialize (rows: DefaultRows, cols: DefaultCols, mines: DefaultMines)
			@table = Minesweeper::TableEntity.new(rows, cols, mines)
			@renderer = Minesweeper::Render.new(@table)
		end

	end
end
