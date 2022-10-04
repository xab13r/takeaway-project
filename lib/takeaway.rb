require_relative 'order'
require_relative 'menu'
require_relative 'text_client'

class Takeaway
	def initialize
		@order = Order.new
		@menu = Menu.new
		set_up_menu
	end

	def show_menu
		return @menu.show
	end

	def current_order
		return @order.show_order
	end

	def add_item(dish_name, quantity)
		# if dish is on the menu then can be added to the order
		dish_to_add = show_menu.find {|item| item[:name] == dish_name }
		if dish_to_add
			@order.add(dish_to_add, quantity)
		else
			fail "Dish not on the menu"
		end
	end

	def show_total_bill
		return @order.grand_total
	end

#	def order_status
#		return @is_placed
#	end

	def place_order(phone_number)
		# Initialized TextClient
		client = TextClient.new
		twilio_client = client.create_client
		# Initialized TextComms class
		text_comms = TextComms(twilio_client)
		#TODO continue integration of TextComms

	end

	private

	def set_up_menu
		@menu.add("Fish and Chips", 15)
		@menu.add("Burger and Fries", 20)
		@menu.add("Lamb Kebab", 18)
	end

end

#takeaway = Takeaway.new
#takeaway.add_item("Fish and Chips", 2)
