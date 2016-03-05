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

		private

		def parse_options
			@opts = Trollop::options do
				opt :games,       "Number of games to run", 					short: '-g', default: Defaults[:games]
				opt :rows,        "Number of rows", 									short: '-r', default: Defaults[:rows]
				opt :cols,        "Number of columns", 								short: '-c', default: Defaults[:cols]
				opt :mines,       "Number of mines", 									short: '-m', default: Defaults[:mines]
				opt :boards,      "output board results",             short: '-b', default: false
				opt :interactive, "Set up games/board interactively", short: '-i', default: false
			end
			configure_options @opts[:interactive] ? true : false
		end

		def configure_options(interactive = false)
			option_source = interactive ? ->(k){prompt_for_value(k)} : ->(k){@opts[k]}
			[:games, :rows, :cols, :mines, :boards].each do |option_key|
				instance_variable_set "@#{option_key}".to_sym, option_source.call(option_key)
			end
		end

		def prompt_for_value(key)
			question = "Number of #{key} [#{Defaults[key]}]: "
			cli.ask(question, Integer) {|q| q.default = Defaults[key] }
		end
	end
end