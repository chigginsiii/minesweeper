require 'spec_helper'

RSpec.describe Minesweeper::TableEntity do
	describe '#new' do
		let(:rows) { 11 }
		let(:cols) { 13 }
		let(:mines) { 2 }
		let(:table) { described_class.new rows: rows, cols: cols, mines: mines }

		it 'makes a table' do
			expect(table).to be_a_kind_of Minesweeper::TableEntity
		end
	end

end