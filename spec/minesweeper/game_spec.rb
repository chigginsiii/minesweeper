require 'spec_helper'

RSpec.describe Minesweeper::Game do

	# delegates not tested here include:
	# game.status -> #complete? #in_progress? #won? #lost?
	# game.board  -> #num_rows, #num_cols, #num_mines, 

	include_context 'game setup'
	# includes 'game', which is loaded with a custom board
	# 
	#   M  2  1          F  ◼  ◼
	#   1  3  M    =>    ◼  3  ◼
	#   .  2  M          .  2  ◼


	describe '#flat_board' do
		let(:hidden_board) { " F  ◼  ◼ \n ◼  3  ◼ \n .  2  ◼ " }
		it 'renders board' do
			expect(game.flat_board).to eq hidden_board
		end
	end

	describe '#flat_board' do
		let(:revealed_board) { " M  2  1 \n 1  3  M \n .  2  M " }
		it 'renders board revealed' do
  		expect(game.flat_board_revealed).to eq revealed_board
		end
	end

	describe '#select_cell' do
		let(:board_cell) do
			point = build :point, row: row, col: col
		  game.board.get_cell(point)
		end

		context 'when cell is hidden' do
			let(:row) { 1 }
			let(:col) { 3 }
			before { game.select_cell(row: row, col: col) }

			it 'selects cell' do
				expect(board_cell.coords).to eq '1:3'
			end
		end

		context 'when cell is revealed' do
			let(:row) { 2 }
			let(:col) { 1 }
			before { game.select_cell(row: row, col: col) }

			it 'does nothing' do
				expect(board_cell.revealed?).to eq true
			end
		end

		context 'when cell is flagged' do
			let(:row) { 1 }
			let(:col) { 1 }

			it 'complains' do
				expect { game.select_cell(row: row, col: col) }.to raise_error Minesweeper::SelectError
			end
		end
	end

	describe '#flag_cell' do
		context 'when cell is hidden' do
		end
		context 'when cell is revealed' do
		end
	end

	describe '#unflag_cell' do
		context 'when cell is hidden' do
		end
		context 'when cell is revealed' do
		end
	end

	describe '#toggle_flag' do
		context 'when cell is flagged' do
		end
		context 'when cell is unflagged' do
		end
	end

	describe '#flat_board' do
		let(:flat) do
			[' F  ◼  ◼ ',' ◼  3  ◼ ',' .  2  ◼ '].join("\n")
		end
		it 'renders board' do
			expect(game.flat_board).to eq flat
		end
	end
end
