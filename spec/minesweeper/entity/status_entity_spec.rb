RSpec.describe Minesweeper::StatusEntity do
  let(:status) { described_class.new }

  describe '#new' do
    it 'is :in_progress' do
      expect(status.state).to eq :in_progress
    end
    it 'has result :incomplete' do
      expect(status.result).to eq :incomplete
    end
  end

  describe '#complete' do
    it 'has state :complete' do
      status.complete :won
      expect(status.state).to eq :complete
    end

    context 'when loss' do
      it 'has result :lost' do
        status.complete :lost
        expect(status.result).to eq :lost
      end
    end
    context 'when won' do
      it 'has result :won' do
        status.complete :won
        expect(status.result).to eq :won
      end
    end
    context 'when unknown' do
      it 'complains' do
        expect { status.complete :foo }.to raise_error Minesweeper::StatusError
      end
    end
  end

  describe '#complete?' do
    subject { status.complete? }
    context 'when in progress' do
      it { is_expected.to eq false }
    end
    context 'when complete' do
      before { status.complete :won }
      it { is_expected.to eq true }
    end
  end

  describe '#in_progress?' do
    subject { status.in_progress? }
    context 'when in progress' do
      it { is_expected.to eq true }
    end
    context 'when complete' do
      before { status.complete :won }
      it { is_expected.to eq false }
    end
  end

  describe '#won?' do
    subject { status.won? }
    context 'when result is win' do
      before { status.complete :won }
      it { is_expected.to eq true }
    end
    context 'when result is not win' do
      before { status.complete :lost }
      it { is_expected.to eq false }
    end
  end

  describe '#lost?' do
    subject { status.lost? }
    context 'when result is loss' do
      before { status.complete :lost }
      it { is_expected.to eq true }
    end
    context 'when result is not loss' do
      before { status.complete :won }
      it { is_expected.to eq false }
    end
  end

  describe '#to_s' do
    context 'when in_progress' do
      it 'renders the state' do
        expect("#{status}").to eq status.state.to_s
      end
    end
    context 'when complete' do
      it 'renders the state and result' do
        status.complete :won
        expect("#{status}").to eq "#{status.state}:#{status.result}"
      end
    end
  end
end
