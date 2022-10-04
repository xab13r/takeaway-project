require_relative 'order'
require_relative 'menu'
require_relative 'text_comms'
require_relative 'tokens'

class Takeaway
	def initialize
		# Create an empty order
		@order = Order.new
		# Create an instance of Menu
		@menu = Menu.new
		# Set up Menu
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

	def place_order(phone_number)
		# Create a text client
		twilio_client = create_text_client
		# Initialized TextComms class
		text_comms = TextComms.new(twilio_client)
		#TODO continue integration of TextComms
		text_comms.send_text_confirmation(phone_number)
	end

	private

	# This private method will set up the menu
	# No need to have this as a public method
	def set_up_menu
		@menu.add("Fish and Chips", 15)
		@menu.add("Burger and Fries", 20)
		@menu.add("Lamb Kebab", 18)
	end

	# This private method will set up the text client
	# to be used in TextComms
	# It will return an instance of a Twilio client
	# Set up and ready to use
	def create_text_client
		credentials = TwilioCredentials.new
		auth_token = credentials.auth_token
		account_sid = credentials.account_sid
		client = Twilio::REST::Client.new(account_sid, auth_token)
		return client
	end

end

#takeaway = Takeaway.new
#takeaway.add_item("Fish and Chips", 2)
#p takeaway.show_total_bill
#p takeaway.current_order
#takeaway.place_order("+")
