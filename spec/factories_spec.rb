# verify our factories...

FactoryGirl.factories.map(&:name).each do |factory_sym|
  factory_name = factory_sym.to_s.camelize
  RSpec.describe "the #{factory_name} factory" do
    it 'is valid' do
      expect( build(factory_sym).class.name ).to include 'Minesweeper'
    end
  end
end