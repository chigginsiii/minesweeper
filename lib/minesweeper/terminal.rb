module Minesweeper
  class Terminal
    extend Forwardable
    attr_reader :game, :render, :position
    def_delegators :@render, :draw
    def_delegators :@game, :board, :status, :stats, :num_rows, :num_cols, :num_mines

    def self.new_game(rows:, cols:, mines:)
      new(Minesweeper::Game.new(rows: rows, cols: cols, mines: mines))
    end

    def initialize(game)
      @game   = game
      @position = PositionEntity.new(row: 1, col: 1, rows: game.num_rows, cols: game.num_cols)
      @render   = RenderTerminal.new(game, position)

      write_flash_msg "Good Luck!"
    end

    def dispatch_action(action, *opts)
      return if game.complete?

      case action
      when :move
        move opts[0]
      when :toggle
        toggle_flag
      when :reveal
        reveal_cell
        check_result
      end
    end

    def read_flash_msg
      retval = @flash_message
      @flash_message = ''
      retval
    end
    alias_method :flash, :read_flash_msg

    private

    def check_result
      return if status.in_progress?
      if game.won?
        write_flash_msg "YOU WON!"
      else
        write_flash_msg "YOU LOSE!"
        @render = RenderTerminalHidden.new(self, position)
      end
    end

    def move(dir)
      position.send(dir)
    end

    def toggle_flag
      game.toggle_flag(row: position.row, col: position.col)
    end

    def reveal_cell
      game.select_cell(row: position.row, col: position.col)
    end

    def write_flash_msg(msg)
      @flash_message = msg
    end

  end
end