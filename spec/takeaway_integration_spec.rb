require 'takeaway'
require 'dish'
require 'menu'
require 'dotenv/load' # Just to load environment variables
require 'twilio-ruby'

RSpec.describe 'Takeaway Integration' do
  context "at the beginning" do
    it "creates an empty order" do
      menu = Menu.new
      requester = double :requester
      takeaway = Takeaway.new(menu, requester)
      expect(takeaway.current_order).to eq []
    end

    it 'has a grand total of 0' do
      menu = Menu.new
      requester = double :requester
      takeaway = Takeaway.new(menu, requester)
      expect(takeaway.grand_total).to eq 0
    end

    it "can show a menu" do
      dish = Dish.new("item_1", 1)
      menu = Menu.new
      menu.add(dish)
      requester = double :requester
      takeaway = Takeaway.new(menu, requester)
      expect(takeaway.show_menu).to eq [{ name: "item_1", price: 1 }]
    end

    it "fails to place an order" do
      menu = Menu.new
      requester = double :requester
      takeaway = Takeaway.new(menu, requester)
      expect { takeaway.place_order("+447000000000") }.to raise_error "Order is empty"
    end
  end

  context "if a dish in on the menu" do
    it "can add the dish to the order" do
      dish_1 = Dish.new("item_1", 1)
      dish_2 = Dish.new("item_2", 2)
      menu = Menu.new
      menu.add(dish_1)
      menu.add(dish_2)
      requester = double :requester
      takeaway = Takeaway.new(menu, requester)
      takeaway.add_item("item_1", 2)
      expect(takeaway.current_order).to eq [{ name: "item_1", quantity: 2, price: 2 }]
    end
  end

  context "if a dish is not on the menu" do
    it "fails" do
      dish_1 = Dish.new("item_1", 1)
      menu = Menu.new
      menu.add(dish_1)
      requester = double :requester
      takeaway = Takeaway.new(menu, requester)
      expect { takeaway.add_item("item_2", 2) }.to raise_error "Dish not on the menu"
    end
  end

  context "after adding a few dishes" do
    it "can display an itemized receipt and a grand total" do
      dish_1 = Dish.new("item_1", 1)
      dish_2 = Dish.new("item_2", 2)
      dish_3 = Dish.new("item_3", 3)
      menu = Menu.new
      menu.add(dish_1)
      menu.add(dish_2)
      menu.add(dish_3)
      requester = double :requester
      takeaway = Takeaway.new(menu, requester)
      takeaway.add_item("item_1", 2)
      takeaway.add_item("item_2", 4)
      takeaway.add_item("item_3", 1)

      expect(takeaway.current_order).to eq [
        { name: "item_1", quantity: 2, price: 2 },
        { name: "item_2", quantity: 4, price: 8 },
        { name: "item_3", quantity: 1, price: 3 }
      ]
      expect(takeaway.grand_total).to eq 13
    end

    # This is excluded as it will actually call the API
    # Check takeaway_spec.rb for a mocked version
    xit "can place the order" do
      dish_1 = Dish.new("item_1", 1)
      dish_2 = Dish.new("item_2", 2)
      dish_3 = Dish.new("item_3", 3)
      menu = Menu.new
      menu.add(dish_1)
      menu.add(dish_2)
      menu.add(dish_3)

      client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
      takeaway = Takeaway.new(menu, client)
      takeaway.add_item("item_1", 2)
      takeaway.add_item("item_2", 4)
      takeaway.add_item("item_3", 1)

      expect(takeaway.place_order("+44740000000")).to eq "Order complete!"
    end
  end
end
