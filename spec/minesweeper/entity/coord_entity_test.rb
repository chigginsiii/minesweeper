RSpec.describe Minesweeper::CoordEntity do
	let(:coord) { described_class.new row: 3, col: 2 }
	let(:board) { [[1,2,3],[4,5,6],[7,8,9]] }

	describe '#to_s' do
		it 'renders to string' do
			expect(coord.to_s).to eq "3:2"
		end
	end

	describe '#get_cell' do
		it 'gets a cell from a board' do
			expect(coord.get_cell board).to eq 8
		end
	end

	describe '#put_cell' do
		it 'puts a cell on a board' do
			coord.put_cell board, 'hello'
			expect(coord.get_cell board).to eq 'hello'
		end
	end
end

RSpec.describe Minesweeper::PositionEntity do
	let(:row) { 1 }
	let(:col) { 1 }
	let(:position) do
	  described_class.new(
	    rows: 3, cols: 5,
	    row: row, col: col
	  )
  end

	describe '#right' do
		context 'when position can move right' do
			it 'increments column' do
				position.right
				expect(position.col).to eq 2
			end
		end
		context 'when position is farthest right' do
			let(:col) { 5 }
			it 'stays put' do
				position.right
				expect(position.col).to eq 5
			end
		end
	end

	describe '#left' do
		context 'when position can move left' do
			let(:col) { 3 }
			it 'decrements column' do
				position.left
				expect(position.col).to eq 2
			end
		end

		context 'when position is farthest left' do
			let(:col) { 1 }
			it 'stays put' do
				position.left
				expect(position.col).to eq 1
			end
		end
	end

	describe '#up' do
		context 'when position can move up' do
			let(:row) { 3 }
			it 'decrements row' do
				position.up
				expect(position.row).to eq 2
			end
		end
	
		context 'when position is top row' do
			let(:row) { 1 }
			it 'stays put' do
				position.up
				expect(position.row).to eq 1
			end
		end
	end

	describe '#down' do
		context 'when position can move down' do
			let(:row) { 1 }
			it 'increments row' do
				position.down
				expect(position.row).to eq 2
			end
		end
		context 'when position is bottom row' do
			let(:row) { 3 }
			it 'stays put' do
				position.down
				expect(position.row).to eq 3
			end
		end
	end
end
