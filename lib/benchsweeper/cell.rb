module Benchsweeper
  class Cell

    # XXX: 
    # currently uses array indices to initialize, should
    # have it do row/col and then provide a from_indices method

    attr_reader :value, :row, :col
    def initialize(val, row_i, col_i)
      @value = val
      @row   = row_i + 1
      @col   = col_i + 1
    end

    def status
      @status ||= case value
      when 'F'
        :flagged
      when 'M'
        :mine
      when /^(\d|\.)$/
        :revealed
      else
        :hidden
      end
    end

    def adjacent_mines
      value == '.' ? 0 : cell.to_i
    end

    # query methods, eg:
    #
    # def hidden?
    # status == :hidden
    # end

    [ :hidden, :flagged, :mine, :revealed ].each do |key|
      define_method "#{key}?".to_sym do
        status == key
      end
    end

    def coords
      "#{row}:#{col}"
    end

    # position helpers

    def up
      row - 1
    end

    def down
      row + 1
    end

    def left
      col - 1
    end

    def right
      col + 1
    end
  end
end