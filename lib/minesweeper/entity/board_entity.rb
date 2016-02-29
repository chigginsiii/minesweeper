module Minesweeper
	class BoardEntity
		attr_reader :rows, :cols

		DefaultRows = 6
		DefaultCols = 4

		def initialize (rows: DefaultRows, cols: DefaultCols)
			@rows = rows
			@cols = cols
		end

	end
end
