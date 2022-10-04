require 'takeaway_2'
require 'menu'
require 'order'

RSpec.describe Takeaway do
	context "at the beginning" do
		it "creates an empty order" do
			menu = double :menu
			order = double :order
			# This are needed because Menu is set up as soon
			# as an instance of Takeaway is created
			allow(menu).to receive(:add).with("Fish and Chips", 15)
			allow(menu).to receive(:add).with("Burger and Fries", 20)
			allow(menu).to receive(:add).with("Lamb Kebab", 18)
			allow(order).to receive(:show_order).and_return([])

			takeaway = Takeaway.new(menu, order)
			expect(takeaway.current_order).to eq []
		end

		it 'has a grand total of 0' do
			order = double :order
			menu = double :menu
			allow(menu).to receive(:add).with("Fish and Chips", 15)
			allow(menu).to receive(:add).with("Burger and Fries", 20)
			allow(menu).to receive(:add).with("Lamb Kebab", 18)
			allow(order).to receive(:grand_total).and_return(0)
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.show_total_bill).to eq 0
		end

		it "can show a menu" do
			order = double :order
			menu = double :menu
			allow(menu).to receive(:add).with("Fish and Chips", 15)
			allow(menu).to receive(:add).with("Burger and Fries", 20)
			allow(menu).to receive(:add).with("Lamb Kebab", 18)

			menu_output = [
				{name: "Fish and Chips", price: 15},
				{name: "Burger and Fries", price: 20},
				{name: "Lamb Kebab", price: 18}
			]

			allow(menu).to receive(:show).and_return(menu_output)
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.show_menu).to eq [
				{name: "Fish and Chips", price: 15},
				{name: "Burger and Fries", price: 20},
				{name: "Lamb Kebab", price: 18}
			]
		end
	end

	context "if a dish in on the menu" do
		it "can add the dish to the order" do
			order = double :order
			menu = double :menu
			allow(menu).to receive(:add).with("Fish and Chips", 15)
			allow(menu).to receive(:add).with("Burger and Fries", 20)
			allow(menu).to receive(:add).with("Lamb Kebab", 18)

			menu_output = [
				{name: "Fish and Chips", price: 15},
				{name: "Burger and Fries", price: 20},
				{name: "Lamb Kebab", price: 18}
			]
			allow(menu).to receive(:show).and_return(menu_output)
			allow(order).to receive(:add).with({name: "Fish and Chips", price: 15}, 2)
			allow(order).to receive(:show_order).and_return([{name: "Fish and Chips", quantity:2, price: 30}])
			takeaway = Takeaway.new(menu, order)
			takeaway.add_item("Fish and Chips", 2)
			expect(takeaway.current_order).to eq [{name: "Fish and Chips", quantity:2, price: 30}]
		end
	end

	context "if a dish is not on the menu" do
		it "fails" do
			order = double :order
			menu = double :menu
			allow(menu).to receive(:add).with("Fish and Chips", 15)
			allow(menu).to receive(:add).with("Burger and Fries", 20)
			allow(menu).to receive(:add).with("Lamb Kebab", 18)
			allow(order).to receive(:add).with(:name, :price)

			menu_output = [
				{name: "Fish and Chips", price: 15},
				{name: "Burger and Fries", price: 20},
				{name: "Lamb Kebab", price: 18}
			]

			allow(menu).to receive(:show).and_return(menu_output)

			takeaway = Takeaway.new(menu, order)
			expect { takeaway.add_item("This is not on the menu", 2) }.to raise_error "Dish not on the menu"
		end
	end

	context "after adding a few dishes" do
		it "can display an itemized receipt" do
			order = double :order
			menu = double :menu
			allow(menu).to receive(:add).with("Fish and Chips", 15)
			allow(menu).to receive(:add).with("Burger and Fries", 20)
			allow(menu).to receive(:add).with("Lamb Kebab", 18)

			allow(order).to receive(:add).with({name: "Fish and Chips", price: 15}, 2)
			allow(order).to receive(:add).with({name: "Lamb Kebab", price: 18}, 1)
			allow(order).to receive(:add).with({name: "Burger and Fries", price: 20}, 4)
			menu_output = [
				{name: "Fish and Chips", price: 15},
				{name: "Burger and Fries", price: 20},
				{name: "Lamb Kebab", price: 18}
			]

			allow(menu).to receive(:show).and_return(menu_output)
			allow(order).to receive(:show_order).and_return([
					{name: "Fish and Chips", quantity:2, price: 30},
					{name: "Burger and Fries", quantity:4, price: 80},
					{name: "Lamb Kebab", quantity:1, price: 18}
				])

			takeaway = Takeaway.new(menu, order)
			takeaway.add_item("Fish and Chips", 2)
			takeaway.add_item("Burger and Fries", 4)
			takeaway.add_item("Lamb Kebab", 1)
			expect(takeaway.current_order).to eq [
				{name: "Fish and Chips", quantity:2, price: 30},
				{name: "Burger and Fries", quantity:4, price: 80},
				{name: "Lamb Kebab", quantity:1, price: 18}
			]
		end

		it "can display a grand total" do
			order = double :order
			menu = double :menu
			allow(menu).to receive(:add).with("Fish and Chips", 15)
			allow(menu).to receive(:add).with("Burger and Fries", 20)
			allow(menu).to receive(:add).with("Lamb Kebab", 18)

			menu_output = [
				{name: "Fish and Chips", price: 15},
				{name: "Burger and Fries", price: 20},
				{name: "Lamb Kebab", price: 18}
			]

			allow(menu).to receive(:show).and_return(menu_output)

			allow(order).to receive(:add).with({name: "Fish and Chips", price: 15}, 2)
			allow(order).to receive(:add).with({name: "Lamb Kebab", price: 18}, 1)
			allow(order).to receive(:add).with({name: "Burger and Fries", price: 20}, 4)
			allow(order).to receive(:grand_total).and_return(128)
			takeaway = Takeaway.new(menu, order)
			takeaway.add_item("Fish and Chips", 2)
			takeaway.add_item("Burger and Fries", 4)
			takeaway.add_item("Lamb Kebab", 1)
			expect(takeaway.show_total_bill).to eq 128
		end

		xit "can place the order" do
			order = Order.new
			menu = Menu.new
			takeaway = Takeaway.new(order, menu)
			takeaway.add_item("Fish and Chips", 2)
			takeaway.add_item("Burger and Fries", 4)
			takeaway.add_item("Lamb Kebab", 1)
			#takeaway.place_order('07000000000')
			#expect(takeaway.order_status).to eq true
		end
	end
end