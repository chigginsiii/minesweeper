module Minesweeper
	class PositionEntity
		attr_accessor :row, :col
		
		Moves = {
		  :up 	  => Proc.new { |p| p.row -= 1 unless p.row <= 1 },
		  :down 	=> Proc.new { |p| p.row += 1 unless p.row >= num_rows },
		  :left 	=> Proc.new { |p| p.col -= 1 unless p.col <= 1 },
		  :right	=> Proc.new { |p| p.col += 1 unless p.col >= num_cols }
		}

		def initialize(row:, col:)
			@row = row
			@col = col
		end


	end
end