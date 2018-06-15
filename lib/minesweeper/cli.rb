#
# This is copied from the Benchsweeper::CLI module and is nearly identical
# so that when they're viewed side-by-side, the pattern to abstract should
# be clear.
#
# It's looking like both bin/minesweeper and bin/benchsweeper could use these
# as a DSL for making this very nice configuration package.  
# - set the name/label of the option, the type, the default, and the short version
# - DSL sets the defaults
# - DSL sets up the Trollop block
# - DSL sets up the keys for the configure_options method
#
# I think that would do it, yesno?
#
module Minesweeper
  class CLI
    attr_accessor :rows, :cols, :mines

    Defaults = {
      rows:  12,
      cols:  10,
      mines: 20
    }

    def self.configure
      c = new
    end

    def initialize
      @cli = HighLine.new
      parse_options
    end

    def to_s
      "#{rows} x #{cols} board with #{mines} mines"
    end

    private

    def parse_options
      @opts = Trollop::options do
        opt :rows,    "Number of rows",                 short: '-r', default: Defaults[:rows]
        opt :cols,    "Number of columns",                short: '-c', default: Defaults[:cols]
        opt :mines,   "Number of mines",                  short: '-m', default: Defaults[:mines]
        opt :interactive, "Set up games/board interactively", short: '-i', default: false
      end
      configure_options(@opts[:interactive] ? true : false)
    end

    def configure_options(interactive = false)
      option_source = interactive ? ->(k){prompt_for_value(k)} : ->(k){@opts[k]}
      [:rows, :cols, :mines].each do |option_key|
        instance_variable_set "@#{option_key}".to_sym, option_source.call(option_key)
      end
    end

    def prompt_for_value(key)
      question = "Number of #{key} [#{Defaults[key]}]: "
      @cli.ask(question, Integer) {|q| q.default = Defaults[key] }
    end
  end
end