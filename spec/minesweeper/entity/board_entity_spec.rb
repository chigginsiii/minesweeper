require 'spec_helper'

RSpec.describe Minesweeper::BoardEntity do
	describe '#new' do
		it 'creates a new board' do
			expect(described_class.new).to be_a_kind_of Minesweeper::BoardEntity
		end
	end
end

