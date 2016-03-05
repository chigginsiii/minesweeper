module Benchsweeper
	class CLI
		attr_accessor :games, :rows, :cols, :mines, :boards

		Defaults = {
			games: 100,
			rows:  10,
			cols:  10,
			mines: 10
		}

		def self.configure
			c = new
		end

		def initialize
			parse_options
		end

		def to_s
			"Running #{games} games on a #{rows} x #{cols} board with #{mines} mines"
		end

		def parse_options
			@opts = Trollop::options do
				opt :games,       "Number of games to run", 					short: '-g', default: Defaults[:games]
				opt :rows,        "Number of rows", 									short: '-r', default: Defaults[:rows]
				opt :cols,        "Number of columns", 								short: '-c', default: Defaults[:cols]
				opt :mines,       "Number of mines", 									short: '-m', default: Defaults[:mines]
				opt :boards,      "output board results",             short: '-b', default: false
				opt :interactive, "Set up games/board interactively", short: '-i', default: false
			end

			if @opts[:interactive]
				configure_interactive
			else
				@games  = @opts[:games]
				@rows   = @opts[:rows]
				@cols   = @opts[:cols]
				@mines  = @opts[:mines]
				@boards = @opts[:boards]
			end
		end

		def configure_interactive
			cli = HighLine.new
			@games = cli.ask("Number of games [#{Defaults[:games]}]: ", Integer) {|q| q.default = Defaults[:games] }
			@rows  = cli.ask("Number of rows [#{Defaults[:rows]}]: ", Integer)   {|q| q.default = Defaults[:rows]  }
			@cols  = cli.ask("Number of cols [#{Defaults[:cols]}]: ", Integer)   {|q| q.default = Defaults[:cols]  }
			@mines = cli.ask("Number of mines [#{Defaults[:mines]}]: ", Integer) {|q| q.default = Defaults[:mines] }
		end
	end
end