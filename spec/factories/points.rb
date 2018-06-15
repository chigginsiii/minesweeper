FactoryGirl.define do
  factory :point, class: Minesweeper::PointEntity do
    skip_create
    
    row 1
    col 1

    initialize_with { new row: row, col: col }
  end
end