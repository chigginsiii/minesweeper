require 'spec_helper'

RSpec.describe Minesweeper::BoardEntity do
	describe '#new' do
		context 'without params' do
			let(:board) { described_class.new }

			it 'creates a new board' do
				expect(described_class.new).to be_a_kind_of Minesweeper::BoardEntity
			end

			it 'has a default dimension' do
				expect(board.rows).to eq Minesweeper::BoardEntity::DefaultRows
			end
		end

		context 'with params' do
			let(:rows) { 7 }
			let(:cols) { 5 }
			let(:board) { described_class.new(rows: rows, cols: cols) }

			it 'sets up rows' do
				expect(board.rows).to eq rows
			end

			it 'sets up columns' do
				expect(board.cols).to eq cols
			end		
		end
	end
end

