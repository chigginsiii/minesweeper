require 'spec_helper'

RSpec.describe Minesweeper::BoardEntity do
	describe '#new' do
		context 'without params' do
			let(:board) { described_class.new }

			it 'creates a new board' do
				expect(described_class.new).to be_a_kind_of Minesweeper::BoardEntity
			end

			it 'has a default dimension' do
				expect(board.num_rows).to eq Minesweeper::BoardEntity::DefaultRows
			end

			it 'has a default number of mines' do
				expect(board.num_mines).to eq Minesweeper::BoardEntity::DefaultMines
			end
		end

		let(:rows) { 7 }
		let(:cols) { 5 }
		let(:mines) { 25 }
		let(:board) { described_class.new(rows: rows, cols: cols, mines: mines) }

		context 'with valid params' do
			it 'sets up rows' do
				expect(board.num_rows).to eq rows
			end

			it 'sets up columns' do
				expect(board.num_cols).to eq cols
			end

			it 'sets up mines' do
				expect(board.num_mines).to eq mines
			end

			it 'loads the board' do
			end
		end

		context 'with invalid rows param' do
			let(:rows) { Minesweeper::TableEntity::MaxRows + 1}
			it 'raises an exception' do
				expect { board }.to raise_exception Minesweeper::TableError
			end
		end

		context 'with invalid cols param' do
			let(:cols) { Minesweeper::TableEntity::MaxCols + 1}
			it 'raises an exception' do
				expect { board }.to raise_exception Minesweeper::TableError
			end
		end
	end

	describe '#draw' do
		let(:board) { described_class.new(rows: 8, cols: 10, mines: 15) }
		it "draws" do
			puts board.draw
		end
	end

end
