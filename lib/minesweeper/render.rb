module Minesweeper
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

		ColSeparator = ' '

		def initialize(game)
			# this should probably take a game or a board?
			@game = game
			@board = game.board
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
				rows.push row.join(ColSeparator)
			end
			rows.join("\n")
		end

		private

		#
		# XXX: these could be moved into CellRenderer, same for Hidden/Array
		#

		def render_cell(cell)
			cell.point == game.position ? "[#{cell_status}]" : " #{cell_status} "
		end

		def cell_status(cell)
			case
			when cell.flagged?
				@cell_render.flag
			when cell.hidden?
				@cell_render.hidden
			when cell.mine?
				@cell_render.mine
			else
				@cell_render.cell cell, board
			end
		end
	end

	class RenderHidden < Render
		def render_cell(cell)
			" #{cell_status} "
		end

		def cell_status(cell)
			case
			when cell.mine?
				@cell_render.mine
			else
				@cell_render.cell cell, board
			end
		end
	end

	# take the board.board, sub out for text
	# XXX: dry this up once abstraction is clear.
	class RenderArray < Render
		ColSeparator = ''

		def render_cell(cell)
			cell_status cell
		end
	end
end

