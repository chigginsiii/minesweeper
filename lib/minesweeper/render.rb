module Minesweeper
	class Render
		def initialize(table)
			@table = table
		end

		def draw(cell_renderer = RenderCellHidden)
			rows = []
			(1..@table.num_rows).each do |r|
				row = []
				(1..@table.num_cols).each do |c|
					row.push cell_renderer.render @table.get_cell(r,c)
				end
				rows.push row.join('')
			end
			puts rows.join("\n")
		end

		def draw_revealed
			draw(RenderCellRevealed)
		end

		def render(cell)
			self.send @renderer, cell
		end
	end

	class RenderCellHidden
		def self.render(cell)
			cell.hidden? ? 'X' : RenderCellRevealed.render(cell)
		end
	end

	class RenderCellRevealed
		def self.render(cell)
			cell.mine? ? 'B' : 's'
		end
	end
end