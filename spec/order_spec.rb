# Unit Testing Order Class: Complete

require 'order'

RSpec.describe Order do
	context "at the beginning" do

		it "has a grand total of 0" do
			order = Order.new
			expect(order.grand_total).to eq 0
		end

		it "has an empty receipt" do
			order = Order.new
			expect(order.show_order).to eq []
		end
	end

	it "can add dishes to the order" do
		order = Order.new
		order.add({name: "Fish and Chips", price:15}, 2)
		order.add({name: "Burgers and Fries", price:20}, 3)
		expect(order.show_order).to eq [
			{name: "Fish and Chips", quantity: 2, price: 30},
			{name: "Burgers and Fries", quantity: 3, price: 60}
		]
	end

	it "can show a grand total" do
		order = Order.new
		dish_1 = {name: "Fish and Chips", price:15}
		dish_2 = {name: "Burgers and Fries", price:20}
		order.add(dish_1, 2)
		order.add(dish_2, 3)
		expect(order.grand_total).to eq 90
	end

	it "fails if quantity is not a number" do
			order = Order.new
			dish_1 = {name: "Fish and Chips", price:15}
			expect { order.add(dish_1, "15") }.to raise_error "Quantity must be a number"
		end
end