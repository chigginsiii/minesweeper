require 'rspec'

RSpec.describe Minesweeper::CellEntity do

	describe '#new' do
		it 'returns a cell entity' do
			expect(described_class.new).to be_a_kind_of Minesweeper::CellEntity
		end
	end

end