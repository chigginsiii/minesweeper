RSpec.describe Minesweeper::StatusEntity do

	describe '#new' do
		it 'has state :incomplete, result :incomplete'
	end

	describe '#complete' do
		it 'has state :complete'
		context 'when loss' do
			it 'has result :lost'
		end
		context 'when won' do
			it 'has result :won'
		end
		context 'when unknown' do
			it 'complains'
		end
	end

end
