
RSpec.describe Minesweeper::BoardEntity do
  let(:rows) { 10 }
  let(:cols) { 8 }
  let(:mines) { 15 }
  let(:board) { described_class.new rows, cols, mines }

  describe '#new' do
    it 'sets rows' do
      expect(board.num_rows).to eq rows
    end

    it 'sets cols' do
      expect(board.num_cols).to eq cols
    end

    it 'sets mines' do
      expect(board.num_mines).to eq mines
    end
  end

  #
  # query
  #

  describe '#get_cell' do
    let(:row) { 2 }
    let(:col) { 5 }
    let(:point) { Minesweeper::PointEntity.new row: row, col: col }
    let(:cell) { board.get_cell point }

    it 'returns correct cell' do
      expect(cell.point).to eq point
    end
  end

  describe '#all_cells' do
    it 'returns all cells' do
      expect(board.all_cells.count).to eq rows * cols
    end
  end

  describe '#hidden_cells' do
    it 'returns hidden cells' do
      expect(board.hidden_cells).to eq board.all_cells.select {|c| c.hidden? }
    end
  end

  describe '#revealed_cells' do
    it 'returns revealed cells' do
      expect(board.revealed_cells).to eq board.all_cells.select {|c| c.revealed? }
    end
  end

  describe '#flagged_cells' do
    it 'returns flagged cells' do
      expect(board.flagged_cells).to eq board.all_cells.select {|c| c.flagged? }
    end
  end

  describe '#adjacent_cells' do
    let (:adjacent_cells) { board.adjacent_cells(cell) }

    context 'in the middle of the board' do
      let(:cell) { board.get_cell( Minesweeper::PointEntity.new(col: 5, row: 4)) }
      it 'gets 8 adjacent cells' do
        expect(adjacent_cells.length).to eq 8
      end
    end

    context 'on the side' do
      let(:cell) { board.get_cell(Minesweeper::PointEntity.new(col: 8, row: 3)) }
      it 'gets 6 cells' do
        expect(adjacent_cells.length).to eq 5
      end
    end

    context 'on the top' do
      let(:cell) { board.get_cell(Minesweeper::PointEntity.new(col: 4, row: 1)) }
      it 'gets 6 cells' do
        expect(adjacent_cells.length).to eq 5
      end
    end

    context 'in the corner' do
      let(:cell) { board.get_cell(Minesweeper::PointEntity.new(col: 1, row: 1)) }
      it 'gets 3 cells' do
        expect(adjacent_cells.length).to eq 3
      end
    end
  end

  describe '#adjacent_mines' do
    let(:cell_array) do
      (1..5).map do |col|
        point = Minesweeper::PointEntity.new row: 1, col: col
        if col < 3
          Minesweeper::CellEntity.mine point: point
        else
          Minesweeper::CellEntity.safe point: point
        end
      end
    end 
    before { allow(board).to receive(:adjacent_cells).and_return(cell_array)}
    it 'gets adjacent mines' do
      cell = double
      expect(board.adjacent_mines(cell).count).to eq 2
    end
  end

  #
  # command
  #

  describe '#reveal_all_cells' do
    it 'reveals all cells' do
      board.reveal_all_cells
      expect(board.all_cells.select{|c| c.revealed? }).to eq board.all_cells
    end
  end

  describe '#reveal_adjacent_cells' do
    # this one's going to take more thought.
    # case 1 just involves revealing adjacent cells to the original cells,
    # case 2 involves hitting one that touches no mines and recurses.
    # these will likely need to have custom boards made.
  end
end







