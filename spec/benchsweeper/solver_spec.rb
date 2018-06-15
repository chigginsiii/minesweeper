RSpec.describe Benchsweeper::Solver do
  let(:game) { double :flat_board => board }
  let(:solver) { described_class.new game }
  before do
    allow(game).to receive(:flag_cell)
    allow(game).to receive(:select_cell)
  end

  describe '#must_be_mines' do
    # true: 
    # - have a rendered board with two hidden that must be
    # - use 'game' double to verify :flag_cell is called twice with row/col
    # - verify if returns true
    context 'when cell meets criteria' do
      let(:board) { 'X 1 . . . X 2 X'}
      it 'flags cell' do
        expect(game).to receive(:flag_cell).exactly(3).times
        solver.must_be_mines
      end

      it 'returns true' do
        expect(solver.must_be_mines).to eq true
      end
    end

    # false:
    # - have a rendered 2x2 board where '1' revealed and 3 hidden adjacent
    # - verify it returns false
    context 'when no cell meets criteria' do
      let(:board) { ['1 x', 'x x'].join("\n")}

      it 'flags no cells' do
        expect(game).not_to receive(:flag_cell)
        solver.must_be_mines
      end

      it 'returns false' do
        expect(solver.must_be_mines).to eq false
      end
    end
  end

  describe '#must_not_be_mines' do
    # true:
    # - have a rendered board with a 3, two flagged, 5 revealed, 1 hidden
    # - verify select_cell called with hidden coords
    # - verify true
    context 'when cell meets criteria' do
      let(:board) { 'x 1 F 1 .'}

      it 'selects the cell' do
        expect(game).to receive(:select_cell).with(row: 1, col: 1)
        solver.must_not_be_mines
      end

      it 'returns true' do
        expect(solver.must_not_be_mines).to eq true
      end
    end

    # false:
    # - render a 2x2 board with 3 hidden, '1' revealed
    # - verify false
    context 'when no cell meets criteria' do
      let(:board) { ['2 F', 'x x'].join("\n") }

      it 'selects no cells' do
        expect(game).not_to receive(:select_cell)
        solver.must_not_be_mines
      end

      it 'returns false' do
        expect(solver.must_not_be_mines).to eq false
      end
    end
  end

  describe '#pick_random_adjacent' do
    # true:
    # - rendered with 2 revealed: '2' and '1' in a 1x strip
    # - verify select_cell is called with one of the 1's adjacents
    # - verify true
    context 'when cell meets criteria' do
      let(:board) { 'x 2 x x . x x 1 x' }

      it 'selects the cell' do
        expect(game).to receive(:select_cell) do |args|
          args[:col] > 6
        end
        solver.pick_random_adjacent
      end

      it 'returns true' do
        expect(solver.pick_random_adjacent).to eq true
      end
    end

    # false:
    # - rendered all hidden
    # - verify false
    context 'when no cell meets criteria' do
      let(:board) { 'x x x'}
      it 'selects no cells' do
        expect(game).not_to receive(:select_cell)
        solver.pick_random_adjacent
      end

      it 'returns false' do
        expect(solver.pick_random_adjacent).to eq false
      end
    end
  end

  describe '#pick_random' do
    # true
    # verify select_cell called
    # verify true
    let(:board) { 'x 2 x x . . F' }

    it 'selects any hidden cell' do
      expect(game).to receive(:select_cell) do |args|
        [1,3,4].include? args[:col]
      end
      solver.pick_random
    end

    it 'returns true' do
      expect(solver.pick_random).to eq true
    end
  end
end