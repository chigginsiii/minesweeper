require 'spec_helper'

RSpec.describe Minesweeper::Game do
	let(:rows) { 7 }
	let(:cols) { 5 }
	let(:mines) { 10 }
	let(:game) { described_class.new(rows: rows, cols: cols, mines: mines) }

	describe '#new' do		
		context 'with valid params' do
			it 'sets up rows' do
				expect(game.num_rows).to eq rows
			end

			it 'sets up columns' do
				expect(game.num_cols).to eq cols
			end

			it 'sets up mines' do
				expect(game.num_mines).to eq mines
			end

			it 'loads the game' do
			end
		end

		context 'with invalid rows param' do
			let(:rows) { Minesweeper::BoardEntity::MaxRows + 1}
			it 'raises an exception' do
				expect { game }.to raise_exception Minesweeper::BoardError
			end
		end

		context 'with invalid cols param' do
			let(:cols) { Minesweeper::BoardEntity::MaxCols + 1}
			it 'raises an exception' do
				expect { game }.to raise_exception Minesweeper::BoardError
			end
		end
	end

	describe '#reveal_cell' do
		context 'when cell is not a mine' do
		end
		context 'when cell is a mine' do
		end
	end

	describe '#flag_cell' do
		context 'when cell is not revealed' do
			context 'when cell is not flagged' do
			end
			context 'when cell is flagged' do
			end
		end
		context 'when cell has already been revealed' do
		end
	end

end
