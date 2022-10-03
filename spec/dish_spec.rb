require 'dish'

RSpec.describe Dish do
	it "constructs" do
		dish = Dish.new("Fish and Chips", 15)
		expect(dish.name).to eq "Fish and Chips"
		expect(dish.price).to eq 15
	end
end