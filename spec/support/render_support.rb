RSpec.shared_context 'cell_renderer setup' do
	let(:board) { build(:board, rows: 3, cols: 3) }

	# defaults: hidden, unflagged safe cell
	let(:flagged)  		{ false }
	let(:hidden)  		{ true }
	let(:mine)     		{ false }

	# make the middle cell
	let(:point) { build :point, row: 2, col: 2 }
	let(:cell)  do
		traits = []
		traits << :mine if mine
		traits << :revealed unless hidden
		traits << :flagged if flagged
		build :cell, *traits, point: point
	end

	# allow the adjacent cells to be setup here
	let(:adjacent_cells) { [] }
	let(:adjacent_mines) { [] }

	before do
		# board setup
		allow(board).to receive(:adjacent_cells).and_return(adjacent_cells)
		allow(board).to receive(:adjacent_mines).and_return(adjacent_mines)
	end

	# renderer
	let(:cell_renderer) { described_class.new cell, board }
end

#
# this is all for setting up a custom board, I expect it'll
# become useful for something besides render soon and it'll
# get extracted.
#

RSpec.shared_context 'renderer setup' do

	# hidden-cell, revealed-cell, 
	def hc(row,col)
		build :cell, row: row, col: col
	end

	def rc(row,col)
		build :cell, :revealed, row: row, col: col
	end

	# hidden-mine, revealed-mine,
	def hm(row,col)
		build :cell, :mine, row: row, col: col
	end

	def rm(row,col)
		build :cell, :mine, :revealed, row: row, col: col
	end

	# flagged-cell, flagged-mine
	def fc(row,col)
		build :cell, :flagged, row: row, col: col
	end

	def fm(row,col)
		build :cell, :flagged, :mine, row: row, col: col
	end

	let(:rendered_three_by_hidden) do
		[' ◼  1  . ', ' ◼  2  ◼ ', ' F  ◼  F '].join"\n"
	end

	let(:three_by) do
		[
			[ hc(1,1), rc(1,2), rc(1,3) ],
			[ hm(2,1), rc(2,2), hc(2,3) ],
			[ fm(3,1), hc(3,2), fc(3,3) ],
		]
	end
	let(:board)    { build :board, load_board: three_by }
	let(:game)     { double('game', board: board, num_rows: 3, num_cols: 3, num_mines: 3) }
	let(:renderer) { described_class.new game }
end

RSpec.shared_context 'terminal renderer setup' do
	include_context 'renderer setup' do
		let(:rendered_three_by_hidden) do
			[	'[ ◼ ]  1    .  ' ,
        '  ◼    2    ◼  ' ,
        '  F    ◼    F  ' ].join("\n")
    end

    let(:rendered_three_by_revealed) do
    	['  1    1    .  ',
       '  M    2    .  ',
       '  M    2    .  '].join("\n")
		end

		let(:position) { build :point }
		let(:renderer) { described_class.new game, position }
	end
end