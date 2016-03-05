require 'benchsweeper/board'
require 'benchsweeper/cell'
require 'benchsweeper/solver'

module Benchsweeper
	def self.solver(game)
		Solver.new game
	end
end
