RSpec.shared_context 'cell_renderer setup' do
	let(:cell) { double('cell', flagged?: flagged, hidden?: hidden, mine?: mine) }
	let(:flagged) { false }
	let(:hidden)  { false }
	let(:mine)    { false }

	let(:board)   { double('board', adjacent_mines: adjacent_mines) }
	let(:adjacent_mines) { [:one, :two, :three] }

	let(:cell_renderer) { described_class.new cell, board }
end