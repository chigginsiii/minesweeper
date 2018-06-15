module Minesweeper

  #
  # Cell Renderers
  #

  class CellRenderer
    attr_reader :cell, :board
    def initialize(cell, board)
      @cell  = cell
      @board = board
    end

    def self.render(cell, board)
      new(cell,board).render
    end

    def render
      case
      when cell.flagged?
        flag
      when cell.hidden?
        hidden
      when cell.mine?
        mine
      else
        mines_touching
      end
    end

    private

    def flag
      'F'
    end

    def mine
      'M'
    end

    def hidden
      '◼'
    end

    def mines_touching
      mine_count = board.adjacent_mines(cell).count
      mine_count > 0 ? mine_count : '.'
    end
  end

  class HiddenCellRenderer < CellRenderer
    def render
      case
      when cell.mine?
        mine
      else
        mines_touching
      end
    end
  end

  #
  # Board Renderers
  #

  class Render
    attr_reader :game, :board
    ColSeparator = ''

    def initialize(game)
      @game = game
      @board = game.board
      @cell_renderer = CellRenderer
    end

    def draw
      rows = []
      (1..game.num_rows).each do |r|
        row = []
        (1..game.num_cols).each do |c|
          row << draw_cell( get_cell(r,c) )
        end
        rows.push row.join(ColSeparator)
      end
      rows.join("\n")
    end

    private

    def get_cell(r, c)
      board.get_cell PointEntity.new(row: r, col: c)
    end

    def draw_cell(cell)
      rendered = @cell_renderer.render cell, board
      " #{rendered} "
    end
  end

  class RenderHidden < Render
    def initialize(game)
      super
      @cell_renderer = HiddenCellRenderer
    end
  end

  class RenderTerminal < Render
    attr_reader :position
    ColSeparator = ' '

    def initialize(game, position)
      super(game)
      @position = position
    end

    private

    def draw_cell(cell)
      basic_cell = super
      cell.point == position ? "[#{basic_cell}]" : " #{basic_cell} "
    end
  end

  class RenderTerminalHidden < RenderTerminal
    def initialize(game, position)
      super
      @cell_renderer = HiddenCellRenderer
    end

    private

    def draw_cell(cell)
      super.gsub(/[\[\]]/, ' ')
    end
  end
end
