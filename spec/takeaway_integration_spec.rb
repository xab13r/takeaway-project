require 'takeaway'
require 'menu'
require 'order'

RSpec.describe Takeaway do
	context "at the beginning" do
		it "creates an empty order" do
			menu = Menu.new
			order = Order.new
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.current_order).to eq []
		end

		it 'has a grand total of 0' do
			menu = Menu.new
			order = Order.new
			allow(order).to receive(:grand_total).and_return(0)
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.show_total_bill).to eq 0
		end

		it "can show a menu" do
			menu = Menu.new
			order = Order.new
			dish = Dish.new("item_1", 1)
			menu.add(dish)
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.show_menu).to eq [{name: "item_1", price: 1}]
		end

		it "fails to place an order" do
			menu = Menu.new
			order = Order.new
			takeaway = Takeaway.new(menu, order)
			expect { takeaway.place_order("+447000000000") }.to raise_error "Order is empty"
		end
	end

	context "if a dish in on the menu" do
		it "can add the dish to the order" do
			menu = Menu.new
			order = Order.new
			dish_1 = Dish.new("item_1", 1)
			dish_2 = Dish.new("item_2", 2)
			menu.add(dish_1)
			menu.add(dish_2)
			takeaway = Takeaway.new(menu, order)
			takeaway.add_item("item_1", 2)
			expect(takeaway.current_order).to eq [{name: "item_1", quantity:2, price: 2}]
		end
	end

	context "if a dish is not on the menu" do
		it "fails" do
			menu = Menu.new
			order = Order.new
			dish = Dish.new('item_2', 2)
			menu.add(dish)
			takeaway = Takeaway.new(menu, order)
			expect { takeaway.add_item("item_1", 2) }.to raise_error "Dish not on the menu"
		end
	end

	context "after adding a few dishes" do
		it "can display an itemized receipt" do
			dish_1 = Dish.new("item_1", 1)
			dish_2 = Dish.new("item_2", 2)
			dish_3 = Dish.new("item_3", 3)
			order = Order.new
			menu = Menu.new
			menu.add(dish_1)
			menu.add(dish_2)
			menu.add(dish_3)
			order.add("item_1", 2)
			order.add("item_2", 4)
			order.add("item_3", 1)
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.current_order).to eq [
				{name: "item_1", quantity:2, price: 2},
				{name: "item_2", quantity:4, price: 8},
				{name: "item_3", quantity:1, price: 3}
			]
		end

		xit "can display a grand total" do
			order = double :order
			menu = double :menu
			allow(order).to receive(:grand_total).and_return(42)
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.show_total_bill).to eq 42
		end

		#TODO Write test for this
		xit "can place the order" do

		end
	end
end