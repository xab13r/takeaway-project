require_relative 'order'
require_relative 'menu'
require_relative 'text_comms'
require_relative 'tokens'

class Takeaway
	# menu is instance of menu
	# order is instance of order
	def initialize(menu, order, requester)
		@menu = menu
		@order = order
		@requester = requester
	end

	def show_menu
		return @menu.show
	end

	def current_order
		return @order.show_order
	end

	def add_item(dish_name, quantity)
		# if a dish is on the menu then can be added to the order
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

	def place_order(phone_number, requester)
		# Fail if the it's order is empty
		fail "Order is empty" if @order.show_order.empty?

		# Assuming UK phone number, fail if phone is not valid
		fail "Please enter a valid phone number" if phone_number.length != 14 && !phone_number.star_with?("+44")

		# Set up the Twilio client
#		twilio_client = create_text_client
		# Initialized TextComms class
		text_comms = TextComms.new(requester, phone_number)

		return "Order complete!"
	end

end

#takeaway = Takeaway.new(Menu.new, Order.new)
#takeaway.add_item("Fish and Chips", 2)
#p takeaway.show_total_bill
#p takeaway.current_order
#takeaway.place_order("+")
