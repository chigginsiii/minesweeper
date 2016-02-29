module Minesweeper
	class BoardEntity
		extend Forwardable
		def_delegators :@table, :rows, :cols, :mines

		DefaultRows 	= 6
		DefaultCols 	= 4
		DefaultMines 	= 10

		def initialize (rows: DefaultRows, cols: DefaultCols, mines: DefaultMines)
			@table = Minesweeper::TableEntity.new(rows: rows, cols: cols, mines: mines)
		end

	end
end
