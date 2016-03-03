require 'rspec'

RSpec.describe Minesweeper::CellEntity do

	let(:point) { Minesweeper::PointEntity.new( row: 1, col: 1) }
	let(:cell) { described_class.new(point: point) }

	describe '#mine?' do
		context 'when initialized as a mine' do
			let(:cell) { described_class.new(point: point, mine: true) }
			it 'responds true' do
				expect(cell.mine?).to eq true
			end
		end

		context 'when initialized without params' do
			it 'responds false' do
				expect(cell.mine?).to eq false
			end
		end
	end

	describe 'revealed?' do
		context 'before revealing' do
			it 'responds false' do
				expect(cell.revealed?).to eq false
			end
		end

		context 'after revealing' do
			it 'responds false' do
				cell.reveal
				expect(cell.revealed?).to eq true
			end
		end
	end

	describe '#flagged?' do
		context 'before reveal' do
			context 'when initialized' do
				it 'responds false' do
					expect(cell.flagged?).to eq false
				end
			end
			context 'when toggled from false' do
				it 'responds true' do
					cell.toggle_flag
					expect(cell.flagged?).to eq true
				end
			end
			context 'when toggled from true' do
				before { cell.instance_variable_set(:@flagged, true) }
				it 'responds false' do
					cell.toggle_flag
					expect(cell.flagged?).to eq false
				end
			end				
		end
	end
end