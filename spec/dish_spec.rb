require 'dish'

RSpec.describe Dish do
	it "can return the name of the dish" do
		dish = Dish.new("dish name", 20)
		expect(dish.name).to eq "dish name"
	end

	it "can return the price of the dish" do
		dish = Dish.new("dish name", 20)
		expect(dish.price).to eq 20
	end

	it "fails to construct if name is not a string" do
		expect { Dish.new(1, 20) }.to raise_error "Please check your input"
	end

	it "fails to construct if price is not a number" do
		expect { Dish.new("dish_name", "20") }.to raise_error "Please check your input"
	end
end