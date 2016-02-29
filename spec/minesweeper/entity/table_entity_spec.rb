require 'spec_helper'

RSpec.describe Minesweeper::TableEntity do
	describe '#new' do
		let(:rows) { 11 }
		let(:cols) { 13 }
		let(:mines) { 2 }
		let(:table) { described_class.new rows, cols, mines }

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

	describe '#get_cell'
	describe '#put_cell'
	describe '#empty_cell?'
	
end