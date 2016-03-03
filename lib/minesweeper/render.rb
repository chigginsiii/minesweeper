module Minesweeper

	class ColorCellRenderer
		class << self
			def flag
				Paint['F', :red]
			end

			def mine
				Paint['M', :bright, :red]
			end

			def hidden
				Paint['◼', :white]
			end

			def cell(c)
				cell.adjacent_mines.count > 0 ? Paint[cell.adjacent_mines.count, :blue, :bright] : '.'
			end
		end
	end

	class CellRenderer
		class << self
			def flag
				'F'
			end

			def mine
				'M'
			end

			def hidden
				'◼'
			end

			def cell(c)
				c.adjacent_mines.count > 0 ? c.adjacent_mines.count : '.'
			end
		end
	end

	class Render
		attr_reader :game, :table

		def initialize(game)
			@game = game
			@table = game.table
			# curses hates our escaped ansi color codes. shoot.
			@cell_render = CellRenderer
		end

		def draw
			rows = []
			(1..table.num_rows).each do |r|
				row = []
				(1..table.num_cols).each do |c|
					row.push render_cell table.get_cell(row: r, col: c)
				end
				rows.push row.join(' ')
			end
			rows.join("\n")
		end

		# XXX: refactor for dep inject once conditions are clearly defined
		def render_cell(cell)
			cell_status = case
			when cell.flagged?
				@cell_render.flag
			when cell.hidden?
				@cell_render.hidden
			when cell.mine?
				@cell_render.mine
			else
				@cell_render.cell cell
			end
			cell.coords == game.position ? "[#{cell_status}]" : " #{cell_status} "
		end
	end
end

