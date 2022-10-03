require 'menu'
require 'dish'

RSpec.describe "Dish-Menu Integration" do
	it "can add multiple dishes" do
		dish_1 = Dish.new("Fish and Chips", 15)
		dish_2 = Dish.new("Burger and Fries", 20)
		menu = Menu.new
		menu.add(dish_1)
		menu.add(dish_2)
		expect(menu.show).to eq [{name: "Fish and Chips", price: 15}, {name: "Burger and Fries", price: 20},]
	end
end