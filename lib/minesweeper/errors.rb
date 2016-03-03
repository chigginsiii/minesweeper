module Minesweeper
	class Error < StandardError
	end

	class TableError < Error; end
	class SelectError < Error; end
end