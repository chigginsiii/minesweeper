RSpec.describe Minesweeper::StatsEntity do
	let(:status) { double('status', :in_progress? => true) }
	let(:game) { double('game', board: board, status: status)}
	let(:stats) { described_class.new game }
	describe '#cells_total' do
		let(:board) { double('board', all_cells: [:cell1, :cell2, :cell3])}
		it 'counts all cells' do
			expect(stats.cells_total).to eq 3
		end
	end

	describe '#cells_revealed' do
		let(:board) { double('board', revealed_cells: [:cell1, :cell2, :cell3])}
		it 'counts revealed cells' do
			expect(stats.cells_revealed).to eq 3
		end
	end

	describe '#cells_flagged' do
		let(:board) { double('board', flagged_cells: [:cell1, :cell2, :cell3])}
		it 'counts flagged cells' do
			expect(stats.cells_flagged).to eq 3
		end
	end

	describe 'mines' do
		let(:board) { double('board', num_mines: 13) }
		it 'returns number of mines' do
			expect(stats.mines).to eq 13
		end
	end

	describe '#to_s' do
		let(:board) { double('board', all_cells: [:c, :c, :c, :c], num_mines: 2, revealed_cells: [:cell]) }
		context 'while in progress' do
			it 'shows current game status' do
				expect(stats.to_s).to include 'revealed/mines/total'
			end
		end
		context 'after winning' do
			let(:status) { double('status', :in_progress? => false, :won? => true) }
			it 'declares a winner' do
				expect(stats.to_s).to include('WINNER!')
			end
		end
		context 'after losing' do
			let(:status) { double('status', :in_progress? => false, :won? => false) }
			it 'declares a game over' do
				expect(stats.to_s).to include('GAME OVER!')
			end
		end
	end
end