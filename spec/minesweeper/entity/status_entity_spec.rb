RSpec.describe Minesweeper::StatusEntity do
	let(:status) { described_class.new }

	describe '#new' do
		it 'is :in_progress' do
			expect(status.state).to eq :in_progress
		end
		it 'has result :incomplete' do
			expect(status.result).to eq :incomplete
		end
	end

	describe '#complete' do
		it 'has state :complete' do
			status.complete :won
			expect(status.state).to eq :complete
		end

		context 'when loss' do
			it 'has result :lost' do
				status.complete :lost
				expect(status.result).to eq :lost
			end
		end
		context 'when won' do
			it 'has result :won' do
				status.complete :won
				expect(status.result).to eq :won
			end
		end
		context 'when unknown' do
			it 'complains' do
				expect { status.complete :foo }.to raise_error
			end
		end
	end
end
