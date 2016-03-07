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

RSpec.shared_context 'renderer setup' do
	let(:rendered_three_by_hidden) do
		[' ◼  1  . ', ' ◼  2  ◼ ', ' F  ◼  F '].join"\n"
	end

	let(:three_by) do
		cm = CellMaker.new
		[
			[ cm.hc(1,1), cm.rc(1,2), cm.rc(1,3) ],
			[ cm.hm(2,1), cm.rc(2,2), cm.hc(2,3) ],
			[ cm.fm(3,1), cm.hc(3,2), cm.fc(3,3) ],
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