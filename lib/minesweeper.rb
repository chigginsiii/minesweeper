require 'forwardable'
require 'trollop'
require 'highline'

require 'minesweeper/errors'
require 'minesweeper/entity/point_entity'
require 'minesweeper/entity/stats_entity'
require 'minesweeper/entity/status_entity'
require 'minesweeper/entity/board_entity'
require 'minesweeper/entity/cell_entity'
require 'minesweeper/game'
require 'minesweeper/render'
require 'minesweeper/cli'
require 'minesweeper/terminal'

module Minesweeper

	DefaultRows 	= 10
	DefaultCols 	= 12
	DefaultMines 	= 20

	def self.new_game(rows: DefaultRows, cols: DefaultCols, mines: DefaultMines)
		Minesweeper::Game.new(rows: rows, cols: cols, mines: mines)
	end
end
