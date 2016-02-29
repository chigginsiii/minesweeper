require 'rspec'

RSpec.describe Minesweeper::CellEntity do

	describe '#new' do
		it 'returns a cell entity' do
			expect(described_class.new type: :foo).to be_a_kind_of Minesweeper::CellEntity
		end
	end

	describe '#mine?'

	describe '#hidden?'

end