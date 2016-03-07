FactoryGirl.define do
	factory :game, class: Minesweeper::Game do
		skip_create

		rows 	3
		cols 	5
		mines 4

		initialize_with { new(rows: rows, cols: cols, mines: mines) }
	end
end