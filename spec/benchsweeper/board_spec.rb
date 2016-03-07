RSpec.describe Benchsweeper::Board do
	let(:flat_board) do
		<<-FLAT_BOARD
x x F x x
2 4 3 2 .
. 1 F 1 .
		FLAT_BOARD
	end
	let(:game)  { double('game', flat_board: flat_board) }
	let(:board) { described_class.new game }

	describe '#all_cells' do
		it 'returns all cells on the board' do
			expect(board.all_cells.count).to eq 15
		end
	end

	describe '#hidden_cells' do
		it 'returns just the hidden cells' do
			expect(board.hidden_cells.count).to eq 4
		end
	end

	describe '#revealed_cells' do
		it 'returns just the revealed cells' do
			expect(board.revealed_cells.count).to eq 9
		end		
	end

	describe '#get_cell' do
		it 'returns one cell from row/col' do
			expect(board.get_cell(2,3).value.to_i).to eq 3
		end
	end

	describe '#adjacent_cells' do
		let(:cell) { board.get_cell row, col }
		let(:adjacent_values) { board.adjacent_cells(cell).map {|c| c.value } }
		context 'in middle of board' do
			let(:row) { 2 }
			let(:col) { 3 }
			it 'returns 8 adjacent cells' do
				expect(adjacent_values).to eq %w(x F x 4 2 1 F 1)
			end
		end

		context 'on side of board' do
			let(:row) { 2 }
			let(:col) { 1 }
			it 'returns 5 adjacent cells' do
				expect(adjacent_values).to eq %w(x x 4 . 1)
			end
		end

		context 'in corner of board' do
			let(:row) { 3 }
			let(:col) { 1 }
			it 'returns 3 adjacent cells' do
				expect(adjacent_values).to eq %w(2 4 1)
			end
		end
	end
end