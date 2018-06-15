require 'highline'
require 'trollop'

require 'benchsweeper/board'
require 'benchsweeper/cell'
require 'benchsweeper/solver'
require 'benchsweeper/cli'

module Benchsweeper
  def self.solver(game)
    Solver.new game
  end
end
