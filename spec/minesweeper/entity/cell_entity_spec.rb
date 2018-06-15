require 'rspec'

RSpec.describe Minesweeper::CellEntity do
  let(:point) { Minesweeper::PointEntity.new( row: 1, col: 1) }
  let(:cell) { described_class.new(point: point) }

  #
  # query
  #

  describe '#mine?' do
    subject { cell.mine? }
    context 'when cell is a mine' do
      let(:cell) { described_class.new point: point, mine: true }
      it { is_expected.to eq true }
    end
    context 'when cell is not a mine' do
      it { is_expected.to eq false }
    end
  end

  describe '#revealed?' do
    subject { cell.revealed? }
    context 'when cell is revealed' do
      before { cell.instance_variable_set(:@revealed, true) }
      it { is_expected.to eq true }
    end
    context 'when cell is not revealed' do
      it { is_expected.to eq false }
    end
  end

  describe '#flagged?' do
    subject { cell.flagged? }
    context 'when cell is flagged' do
      before { cell.instance_variable_set(:@flagged, true) }
      it { is_expected.to eq true }
    end
    context 'when cell is not flagged' do
      it { is_expected.to eq false }
    end
  end

  describe '#unflagged?' do
    subject { cell.unflagged? }
    context 'when cell is flagged' do
      before { cell.instance_variable_set(:@flagged, true) }
      it { is_expected.to eq false }
    end
    context 'when cell is not flagged' do
      it { is_expected.to eq true }
    end
  end

  describe '#hidden?' do
    subject { cell.hidden? }
    context 'when cell is unflagged and not revealed' do
      it { is_expected.to eq true }
    end
    context 'when cell is flagged' do
      before { cell.instance_variable_set(:@flagged, true) }
      it { is_expected.to eq false }
    end
    context 'when cell is revealed' do
      before { cell.instance_variable_set(:@revealed, true) }
      it { is_expected.to eq false }
    end
  end

  #
  # command
  #

  describe '#reveal!' do
    before { cell.reveal! }
    it 'unflags cell' do
      expect(cell.flagged?).to eq false
    end
    it 'reveals cell' do
      expect(cell.revealed?).to eq true
    end
  end

  describe '#reveal' do
    context 'when cell if flagged' do
      before { cell.flag }
      it 'raise an error' do
        expect { cell.reveal }.to raise_error Minesweeper::SelectError
      end
    end
    context 'when cell is not flagged' do
      before { cell.reveal }
      it 'reveals cell' do
        expect(cell.revealed?).to eq true
      end
    end
  end

  describe '#flag' do
    context 'when cell is revealed' do
      before { cell.reveal }
      it 'raises an error' do
        expect { cell.flag }.to raise_error Minesweeper::SelectError
      end
    end
    context 'when cell is not revealed' do
      before { cell.flag }
      it 'flags cell' do
        expect(cell.flagged?).to eq true
      end
    end
  end

  describe '#unflag' do
    it 'makes flagged? false' do
      cell.flag
      cell.unflag
      expect(cell.flagged?).to eq false
    end
  end

  describe '#toggle_flag' do
    context 'when flagged?' do
      before { cell.flag }
      it 'make cell unflagged?' do
        cell.toggle_flag
        expect(cell.unflagged?).to eq true
      end
    end
    context 'when unflagged?' do
      before { cell.unflag }
      it 'makes cell flagged?' do
        cell.toggle_flag
        expect(cell.flagged?).to eq true
      end
    end
  end

  describe 'status' do
    it 'makes a status string for debugging' do
      expect(cell.status).to eq '-h'
    end
  end
end