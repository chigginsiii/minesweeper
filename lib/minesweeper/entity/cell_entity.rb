module Minesweeper
  class CellEntity
    extend Forwardable
    attr_accessor :point
    def_delegators :@point, :row, :col, :coords

    class << self
      def mine(point:)
        self.new(mine: true, point: point)
      end

      def safe(point:)
        self.new(point: point)
      end
    end

    def initialize (point:, mine: false)
      @point          = point
      @mine       = mine
      @flagged      = false
      @revealed     = false
    end

    #
    # query
    #

    def mine?
      # return nil until revealed?
      @mine == true
    end

    def revealed?
      @revealed == true
    end

    def flagged?
      @flagged == true
    end

    def unflagged?
      !flagged?
    end

    def hidden?
      unflagged? && !revealed?
    end

    #
    # command
    #

    def reveal!
      @flagged = false
      @revealed = true
    end

    def reveal
      raise Minesweeper::SelectError, 'cannot reveal flagged cell' if flagged?
      reveal!
    end

    def flag
      raise Minesweeper::SelectError, 'revealed cell cannot be flagged' if revealed?
      @flagged = true
    end

    def unflag
      @flagged = false
    end

    def toggle_flag
      flagged? ? unflag : flag
    end

    # debug

    def status
      s = mine? ? 'M' : '-'
      s += revealed? ? 'r' : flagged? ? 'f' : 'h'
    end
  end
end