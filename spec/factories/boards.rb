FactoryGirl.define do
  factory :board, class: Minesweeper::BoardEntity do
    skip_create

    transient do
      load_board nil
    end

    rows  { load_board.nil? ? 5 : load_board.length }
    cols  { load_board.nil? ? 7 : load_board[0].length}
    mines { load_board.nil? ? 4 : load_board.flatten.select(&:mine?).count }

    # load custom board: array of arrays of cells
    after(:build) do |board, factory|
      unless factory.load_board.nil?
        board.instance_variable_set(:@board, factory.load_board)
      end
    end

    initialize_with do
      new( rows, cols, mines )
    end
  end
end