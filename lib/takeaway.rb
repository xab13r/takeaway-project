# require_relative 'order'
require_relative 'menu'
# require_relative 'text_comms'
require_relative 'tokens'

class Takeaway
	# menu is instance of menu
	# order is instance of order
	def initialize(menu, requester)
		@menu = menu
		@requester = requester
		@order = Array.new
	end

	def show_menu
		return @menu.show
	end

	def current_order
		return @order
	end

	def add_item(dish_name, quantity)
		# if a dish is on the menu then can be added to the order
		fail "Quanity must be a number" if !quantity.is_a? Numeric
		dish_to_add = show_menu.find {|item| item[:name] == dish_name }
		if dish_to_add
			@order.push({ name: dish_to_add[:name], quantity: quantity, price: quantity * dish_to_add[:price] })
		else
			fail "Dish not on the menu"
		end
	end

	def grand_total
		return @order.sum {|item| item[:price]}
	end

	def place_order(phone_number)
		# Fail if the it's order is empty
		fail "Order is empty" if @order.empty?

		# Assuming UK phone number, fail if phone is not valid
		fail "Please enter a valid phone number" if phone_number.length != 14 && !phone_number.star_with?("+44")

		message = send_text(phone_number)

		if message == 'queued'
			return "Order complete!"
		else
			fail "An error occurred - Please try again"
		end
	end

	private

	def send_text(to_number)
		# Original API call
		# client = Twilio::REST::Client.new(@account_sid, @auth_token)

		delivery_time = (Time.now + 4200).strftime("%H:%M")
		text_body = "Order confirmed! It will be delivered before #{delivery_time}"

		client_messages = @requester.messages
		new_message = client_messages.create(
			from: @from_number,
			to: to_number,
			body: text_body
		)
		return new_message.status
	end

end

#takeaway = Takeaway.new(Menu.new, Order.new)
#takeaway.add_item("Fish and Chips", 2)
#p takeaway.show_total_bill
#p takeaway.current_order
#takeaway.place_order("+")
