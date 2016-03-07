RSpec.describe Minesweeper::Terminal do
	let(:game) { build :game }
	let(:terminal) { described_class.new game }
	describe '#dispatch_action' do

		# this forwards to terminal.position
		context 'when action is :move' do
			it 'changes position' do
				expect(terminal.position).to receive(:up)
				terminal.dispatch_action :move, :up
			end
		end

		# this forwards to game.toggle_flag
		context 'when action is :toggle' do
			it 'toggles flag' do
				expect(terminal.game).to receive(:toggle_flag) do |arg|
					expect(arg).to include( row: terminal.position.row, col: terminal.position.col )
				end
				terminal.dispatch_action :toggle
			end
		end

		# this forwards to game.select_cell
		context 'when action is :reveal' do
			it 'selects cell' do
				expect(terminal.game).to receive(:select_cell) do |arg|
					expect(arg).to include( row: terminal.position.row, col: terminal.position.col )
				end
				terminal.dispatch_action :reveal
			end			
		end
	end

	describe '#flash' do
		before { terminal.send(:write_flash_msg, 'hello') }
		it 'deliver message' do
			expect(terminal.flash).to eq 'hello'
		end

		it 'clears message' do
			terminal.flash
			expect(terminal.flash).to eq ''
		end
	end


end