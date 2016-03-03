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

			def cell(c, b)
				mine_count = b.adjacent_mines(c).count 
				mine_count > 0 ? mine_count : '.'
			end
		end
	end

	class Render
		attr_reader :game, :board

		def initialize(game)
			@game = game
			@board = game.board
			# curses hates our escaped ansi color codes. shoot.
			@cell_render = CellRenderer
		end

		def draw
			rows = []
			(1..board.num_rows).each do |r|
				row = []
				(1..board.num_cols).each do |c|
					p = PointEntity.new(row: r, col: c)
					row.push render_cell board.get_cell p
				end
				rows.push row.join(' ')
			end
			rows.join("\n")
		end

		# XXX: refactor once conditions are clearly defined
		def render_cell(cell)
			cell_status = case
			when cell.flagged?
				@cell_render.flag
			when cell.hidden?
				@cell_render.hidden
			when cell.mine?
				@cell_render.mine
			else
				@cell_render.cell cell, board
			end
			cell.point == game.position ? "[#{cell_status}]" : " #{cell_status} "
		end
	end

	class RenderHidden < Render
		def render_cell(cell)
			cell_status = case
			when cell.mine?
				@cell_render.mine
			else
				@cell_render.cell cell, board
			end
			" #{cell_status} "
		end
	end
end

