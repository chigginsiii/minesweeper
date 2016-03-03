require 'forwardable'
require 'paint'

require 'minesweeper/errors'
require 'minesweeper/entity/point_entity'
require 'minesweeper/entity/status_entity'
require 'minesweeper/entity/game_entity'
require 'minesweeper/entity/board_entity'
require 'minesweeper/entity/cell_entity'
require 'minesweeper/render'

module Minesweeper

	DefaultRows 	= 10
	DefaultCols 	= 12
	DefaultMines 	= 20

	def new_game(rows: DefaultRows, cols: DefaultCols, mines: DefaultMines)
		Minesweeper::Game.new(rows: rows, cols: cols, mines: mines)
	end
end
