require 'takeaway'
#require 'menu'
#require 'order'

RSpec.describe Takeaway do
	context "at the beginning" do
		it "creates an empty order" do
			menu = double :menu
			requester = double :requester
			takeaway = Takeaway.new(menu, requester)
			expect(takeaway.current_order).to eq []
		end

		it 'has a grand total of 0' do
			menu = double :menu
			requester = double :requester
			takeaway = Takeaway.new(menu, requester)
			expect(takeaway.grand_total).to eq 0
		end

		it "can show a menu" do
			menu = double :menu
			requester = double :requester
			allow(menu).to receive(:show).and_return([{name: "item_1", price: 1}])
			takeaway = Takeaway.new(menu, requester)
			expect(takeaway.show_menu).to eq [{name: "item_1", price: 1}]
		end

		it "fails to place an order" do
			menu = double :menu
			requester = double :requester
			takeaway = Takeaway.new(menu, requester)
			expect { takeaway.place_order("+447000000000") }.to raise_error "Order is empty"
		end
	end

	context "if a dish in on the menu" do
		it "can add the dish to the order" do
			menu = double :menu
			requester = double :requester
			menu_output = [
				{name: "item_1", price: 1},
				{name: "item_2", price: 2}
			]
			allow(menu).to receive(:show).and_return(menu_output)
			takeaway = Takeaway.new(menu, requester)
			takeaway.add_item("item_1", 2)
			expect(takeaway.current_order).to eq [{name: "item_1", quantity:2, price: 2}]
		end
	end

	context "if a dish is not on the menu" do
		it "fails" do
			menu = double :menu
			requester = double :requester
			allow(menu).to receive(:show).and_return([])
			takeaway = Takeaway.new(menu, requester)
			expect { takeaway.add_item("item_1", 2) }.to raise_error "Dish not on the menu"
		end
	end

	context "if trying to add a dish with quantity not being a number" do
		it "fails" do
			menu = double :menu
			requester = double :requester
			takeaway = Takeaway.new(menu, requester)
			expect { takeaway.add_item("item_1", '2') }.to raise_error "Quantity must be a number"
		end
	end

	context "after adding a few dishes" do
		it "can display an itemized receipt" do
			menu = double :menu
			requester = double :requester
			allow(menu).to receive(:show).and_return([
					{name: "item_1", price: 1},
					{name: "item_2", price: 2},
					{name: "item_3", price: 3}
				])

			takeaway = Takeaway.new(menu, requester)
			takeaway.add_item("item_1", 2)
			takeaway.add_item("item_2", 4)
			takeaway.add_item("item_3", 1)

			expect(takeaway.current_order).to eq [
				{name: "item_1", quantity:2, price: 2},
				{name: "item_2", quantity:4, price: 8},
				{name: "item_3", quantity:1, price: 3}
			]
		end

		it "can display a grand total" do

			menu = double :menu
			requester = double :requester

			allow(menu).to receive(:show).and_return([
					{name: "item_1", price: 1},
					{name: "item_2", price: 2},
					{name: "item_3", price: 3}
				])

			takeaway = Takeaway.new(menu, requester)
			takeaway.add_item("item_1", 2)
			takeaway.add_item("item_2", 4)
			takeaway.add_item("item_3", 1)

			expect(takeaway.grand_total).to eq 13
		end

		it "can place the order" do
			menu = double :menu
			allow(menu).to receive(:show).and_return([
				{name: "item_1", price: 1},
				{name: "item_2", price: 2},
				{name: "item_3", price: 3}
			])

			new_message = double(:message)
			client_messages = double(:messages, create: new_message)
			requester = double(:requester, messages: client_messages)

			expect(new_message).to receive(:status).and_return("queued")

			takeaway = Takeaway.new(menu, requester)
			takeaway.add_item("item_1", 2)
			takeaway.add_item("item_2", 4)
			takeaway.add_item("item_3", 1)

			expect(takeaway.place_order("+4474000000000")).to eq "Order complete!"
		end

		it "fails if the phone number is not valid" do
			menu = double :menu
			allow(menu).to receive(:show).and_return([
				{name: "item_1", price: 1},
				{name: "item_2", price: 2},
				{name: "item_3", price: 3}
			])

			requester = double(:requester)

			takeaway = Takeaway.new(menu, requester)
			takeaway.add_item("item_1", 2)
			takeaway.add_item("item_2", 4)
			takeaway.add_item("item_3", 1)

			# Phone number is too short
			expect { takeaway.place_order("+440") }.to raise_error "Please enter a valid phone number"
			# Correct number of digit but wrong country code
			expect { takeaway.place_order("+397400000000") }.to raise_error "Please enter a valid phone number"

		end

		it "fails if the Twilio API call doesn't work" do
			menu = double :menu
			allow(menu).to receive(:show).and_return([
				{name: "item_1", price: 1},
				{name: "item_2", price: 2},
				{name: "item_3", price: 3}
			])

			new_message = double(:message)
			client_messages = double(:messages, create: new_message)
			requester = double(:requester, messages: client_messages)

			expect(new_message).to receive(:status).and_return("anything but queued")

			takeaway = Takeaway.new(menu, requester)
			takeaway.add_item("item_1", 2)
			takeaway.add_item("item_2", 4)
			takeaway.add_item("item_3", 1)

			expect { takeaway.place_order("+4407400000000")}.to raise_error "An error occurred - Please try again"
		end
	end
end