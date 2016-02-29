module Minesweeper
	class Render
		def initialize(table)
			@table = table
		end

		def draw
			rows = []
			(1..@table.num_rows).each do |r|
				row = []
				(1..@table.num_cols).each do |c|
					row.push render_cell @table.get_cell(r,c)
				end
				rows.push row.join('')
			end
			puts rows.join("\n")
		end

		def render_cell(cell)
			cell.hidden? ? 'X' : cell.mine? ? 'B' : 's'
		end
	end
end