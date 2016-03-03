module Minesweeper
	class Error < StandardError
	end

	class StatusError < Error; end
	class BoardError < Error; end
	class SelectError < Error; end
end