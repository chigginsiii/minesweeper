FactoryGirl.define do
  factory :cell, class: Minesweeper::CellEntity do
    skip_create
    point

    transient do
      row nil
      col nil
    end

    trait :mine do 
      after(:build) do |cell|
        cell.instance_variable_set :@mine, true
      end
    end

    trait :revealed do
      after(:build) do |cell|
        cell.reveal
      end
    end

    trait :flagged do
      after(:build) do |cell|
        cell.flag
      end
    end

    initialize_with do
      new point: point
    end

    after(:build) do |model, eval|
      if eval.row && eval.col 
        point = create(:point, row: eval.row, col: eval.col)
        model.instance_variable_set :@point, point
      end
    end
  end
end