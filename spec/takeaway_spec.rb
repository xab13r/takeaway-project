require 'takeaway'

RSpec.describe Takeaway do
	context "at the beginning" do
		it "creates an empty order" do
			takeaway = Takeaway.new
			order = double(:order, show_order: [])
			allow(order).to receive(:show_order).and_return([])

			expect(takeaway.current_order).to eq []
		end

		xit 'has a grand total of 0' do
			takeaway = Takeaway.new
			expect(takeaway.show_total_bill).to eq 0
		end

		xit "can show a menu" do
			takeaway = Takeaway.new
			expect(takeaway.show_menu).to eq [
				{name: "Fish and Chips", price: 15},
				{name: "Burger and Fries", price: 20},
				{name: "Lamb Kebab", price: 18}
			]
		end
	end

	context "if a dish in on the menu" do
		xit "can add the dish to the order" do
			takeaway = Takeaway.new
			takeaway.add_item("Fish and Chips", 2)
			expect(takeaway.current_order).to eq [{name: "Fish and Chips", quantity:2, price: 30}]
		end
	end

	context "if a dish is not on the menu" do
		xit "fails" do
			takeaway = Takeaway.new
			expect { takeaway.add_item("This is not on the menu", 2) }.to raise_error "Dish not on the menu"
		end
	end

	context "after adding a few dishes" do
		xit "can display an itemized receipt" do
			takeaway = Takeaway.new
			takeaway.add_item("Fish and Chips", 2)
			takeaway.add_item("Burger and Fries", 4)
			takeaway.add_item("Lamb Kebab", 1)
			expect(takeaway.current_order).to eq [
				{name: "Fish and Chips", quantity:2, price: 30},
				{name: "Burger and Fries", quantity:4, price: 80},
				{name: "Lamb Kebab", quantity:1, price: 18}
			]
		end

		xit "can display a grand total" do
			takeaway = Takeaway.new
			takeaway.add_item("Fish and Chips", 2)
			takeaway.add_item("Burger and Fries", 4)
			takeaway.add_item("Lamb Kebab", 1)
			expect(takeaway.show_total_bill).to eq 128
		end

		xit "can place the order" do
			takeaway = Takeaway.new
			takeaway.add_item("Fish and Chips", 2)
			takeaway.add_item("Burger and Fries", 4)
			takeaway.add_item("Lamb Kebab", 1)
			#takeaway.place_order('07000000000')
			#expect(takeaway.order_status).to eq true
		end
	end
end