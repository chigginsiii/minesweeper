# basic cell renderer
RSpec.describe Minesweeper::CellRenderer do
	include_context 'cell_renderer setup'
	describe '#render' do
		context 'when cell is flagged' do
			let(:flagged) { true }
			it 'renders flag' do
				expect(cell_renderer.render).to eq 'F'
			end
		end
		context 'when cell is hidden' do
			let(:revealed) { false }
			it 'renders hidden' do
				expect(cell_renderer.render).to eq '◼'
			end
		end
		context 'when cell is mine' do
			let(:mine) { true }
			let(:hidden) { false }
			it 'renders mine' do
				expect(cell_renderer.render).to eq 'M'
			end
		end
		context 'when cell is touching mines' do
			let(:hidden) { false }
			let(:adjacent_mines) { [:mine1, :mine2] }
			it 'renders number touching' do
				expect(cell_renderer.render).to eq adjacent_mines.count
			end
		end
		context 'when safe cell touches no mines' do
			let(:hidden) { false }
			let(:revealed) { true }
			let(:adjacent_mines) { [] }
			it 'renders an empty safe' do
				expect(cell_renderer.render).to eq '.'
			end
		end		
	end
end

# renders all cells status (ie: end of game)
RSpec.describe Minesweeper::HiddenCellRenderer do
	include_context 'cell_renderer setup'
	describe '#render' do
		context 'when mine is hidden' do
			let(:mine) { true }
			let(:hidden) { true }
			it 'renders mine' do
				expect(cell_renderer.render).to eq 'M'
			end
		end
		context 'when safe cell is hidden' do
			let(:hidden) { true }
			let(:adjacent_mines) { [:mine] }
			it 'renders num mines touching' do
				expect(cell_renderer.render).to eq adjacent_mines.count
			end
		end
	end
end

#
# the rendered board all come from render_support.rb
#

# basic render for flat board
RSpec.describe Minesweeper::Render do
	include_context 'renderer setup'
	describe '#draw' do
		it 'renders the board' do
			expect(renderer.draw).to eq rendered_three_by_hidden
		end
	end
end

# terminal ui: game in current state
RSpec.describe Minesweeper::RenderTerminal do
	include_context 'terminal renderer setup'
	describe '#draw' do
		it 'renders the board' do
			expect(renderer.draw).to eq rendered_three_by_hidden
		end
	end
end

# terminal ui: reveal all
RSpec.describe Minesweeper::RenderTerminalHidden do
	include_context 'terminal renderer setup'
	describe '#draw' do
		it 'renders the board' do
			expect(renderer.draw).to eq rendered_three_by_revealed
		end
	end
end

