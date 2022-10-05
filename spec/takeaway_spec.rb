require 'takeaway_2'
#require 'menu'
#require 'order'

RSpec.describe Takeaway do
	context "at the beginning" do
		it "creates an empty order" do
			menu = double :menu
			order = double :order
			allow(order).to receive(:show_order).and_return([])
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.current_order).to eq []
		end

		it 'has a grand total of 0' do
			order = double :order
			menu = double :menu
			allow(order).to receive(:grand_total).and_return(0)
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.show_total_bill).to eq 0
		end

		it "can show a menu" do
			order = double :order
			menu = double :menu
			allow(menu).to receive(:show).and_return([{name: "item_1", price: 1}])
			takeaway = Takeaway.new(menu, order)
			expect(takeaway.show_menu).to eq [{name: "item_1", price: 1}]
		end

		it "fails to place an order" do
			order = double :order
			menu = double :menu
			allow(order).to receive(:show_order).and_return([])
			takeaway = Takeaway.new(menu, order)
			expect { takeaway.place_order("+447000000000") }.to raise_error "Order is empty"
		end
	end

	context "if a dish in on the menu" do
		it "can add the dish to the order" do
			order = double :order
			menu = double :menu

			menu_output = [
				{name: "item_1", price: 1},
				{name: "item_2", price: 2}
			]
			allow(menu).to receive(:show).and_return(menu_output)
			allow(order).to receive(:add).with({name: "item_1", price: 1}, 2)
			allow(order).to receive(:show_order).and_return([{name: "item_1", quantity:2, price: 2}])
			takeaway = Takeaway.new(menu, order)
			takeaway.add_item("item_1", 2)
			expect(takeaway.current_order).to eq [{name: "item_1", quantity:2, price: 2}]
		end
	end

	context "if a dish is not on the menu" do
		it "fails" do
			order = double :order
			menu = double :menu

			allow(menu).to receive(:show).and_return([])

			takeaway = Takeaway.new(menu, order)
			expect { takeaway.add_item("item_1", 2) }.to raise_error "Dish not on the menu"
		end
	end

	context "after adding a few dishes" do
		it "can display an itemized receipt" do
			order = double :order
			menu = double :menu

			allow(order).to receive(:show_order).and_return([
					{name: "item_1", quantity:2, price: 2},
					{name: "item_2", quantity:4, price: 8},
					{name: "item_3", quantity:1, price: 3}
				])

			takeaway = Takeaway.new(menu, order)
			expect(takeaway.current_order).to eq [
				{name: "item_1", quantity:2, price: 2},
				{name: "item_2", quantity:4, price: 8},
				{name: "item_3", quantity:1, price: 3}
			]
		end

		it "can display a grand total" do
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