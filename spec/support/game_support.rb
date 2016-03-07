RSpec.shared_context 'game setup' do
	let(:cm) { CellMaker.new }
	let(:custom_cells) do
		# F c c
		# c c M
		# C c M
		[[ cm.fm(1,1), cm.hc(1,2), cm.hc(1,3) ],
		 [ cm.hc(2,1), cm.rc(2,2), cm.hm(2,3) ],
		 [ cm.rc(3,1), cm.rc(3,2), cm.hm(3,3) ]]
	end
	let(:custom_board) { build :board, load_board: custom_cells }

	before do
		allow(Minesweeper::BoardEntity).to receive(:new).and_return(custom_board)
	end

	let(:rows) 	{ 3 }
	let(:cols) 	{ 3 }
	let(:mines) { 3 }
	let(:game) { described_class.new rows: rows, cols: cols, mines: mines }
end