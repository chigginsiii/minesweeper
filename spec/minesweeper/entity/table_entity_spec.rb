require 'spec_helper'

RSpec.describe Minesweeper::TableEntity do
	let(:rows) { 10 }
	let(:cols) { 8 }
	let(:mines) { 15 }
	let(:table) { described_class.new rows, cols, mines }

	describe '#new' do
		it 'sets rows' do
			expect(table.num_rows).to eq rows
		end

		it 'sets cols' do
			expect(table.num_cols).to eq cols
		end

		it 'sets mines' do
			expect(table.num_mines).to eq mines
		end
	end

	describe '#adjacent_cells' do
		let (:adjacent_cells) { table.adjacent_cells(cell) }

		context 'in the middle of the table' do
			let(:cell) { table.get_cell(col: 5, row: 4) }
			it 'gets 8 adjacent cells' do
				expect(adjacent_cells.length).to eq 8
			end
		end

		context 'on the side' do
			let(:cell) { table.get_cell(col: 8, row: 3) }
			it 'gets 6 cells' do
				expect(adjacent_cells.length).to eq 5
			end
		end

		context 'on the top' do
			let(:cell) { table.get_cell(col: 4, row: 1) }
			it 'gets 6 cells' do
				expect(adjacent_cells.length).to eq 5
			end
		end

		context 'in the corner' do
			let(:cell) { table.get_cell(col: 1, row: 1) }
			it 'gets 3 cells' do
				expect(adjacent_cells.length).to eq 3
			end
		end
	end
end