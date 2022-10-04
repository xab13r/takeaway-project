require 'menu'

RSpec.describe Menu do
	it "constructs" do
		menu = Menu.new
	end

	it "can add dishes to the menu" do
		menu = Menu.new
		menu.add("Fish and Chips", 15)
		menu.add("Burger and Fries", 20)
		expect(menu.show).to eq [{name: "Fish and Chips", price: 15}, {name: "Burger and Fries", price: 20}]
	end

	context "if no dish is present" do
		it "fails" do
			menu = Menu.new
			expect { menu.show }.to raise_error "No dish present"
		end
	end
end