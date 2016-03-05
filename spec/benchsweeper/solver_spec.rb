RSpec.describe Benchsweeper::Solver do
	# double 'game' board_flat => rendered_board
	#         - expect flag_cell
	#         - expect select_cell
	let(:board) { 'X 1 . . . X 2 X'}
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
			it 'flags cell' do
				expect(game).to receive(:flag_cell).exactly(3).times
				solver.must_be_mines
			end

			it 'returns true' do
				expect(solver.must_be_mines).to eq true
			end
		end
		context 'when no cell meets criteria' do
			# false:
			# - have a rendered 2x2 board where '1' revealed and 3 hidden adjacent
			# - verify it returns false
		end
	end

	describe '#must_not_be_mines' do
		context 'when cell meets criteria' do
			# true:
			# - have a rendered board with a 3, two flagged, 5 revealed, 1 hidden
			# - verify select_cell called with hidden coords
			# - verify true
		end

		context 'when no cell meets criteria' do
			# false:
			# - render a 2x2 board with 3 hidden, '1' revealed
			# - verify false
		end
	end

	describe '#pick_random_adjacent' do
		context 'when cell meets criteria' do
			# true:
			# - rendered with 2 revealed: '2' and '1' in a 1x strip
			# - verify select_cell is called with one of the 1's adjacents
			# - verify true
		end

		context 'when no cell meets criteria' do
			# false:
			# - rendered all hidden
			# - verify false
		end
	end

	describe '#pick_random' do
		# true
		# verify select_cell called
		# verify true
	end
end