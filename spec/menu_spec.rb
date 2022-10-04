# Unit Testing Menu Class: Complete

require 'menu'

RSpec.describe Menu do
	it "constructs" do
		menu = Menu.new
	end

	it "can add dishes to the menu" do
		dish = double(:dish, name: "dish_1", price: 1)

		menu = Menu.new
		menu.add(dish)
		expect(menu.show).to eq [{name: "dish_1", price: 1}]
	end

	context "if no dish is present" do
		it "fails" do
			menu = Menu.new
			expect { menu.show }.to raise_error "No dish present"
		end
	end
end