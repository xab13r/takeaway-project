require_relative 'order'
require_relative 'menu'
require_relative 'dish'

class Takeaway
	def initialize
		@order = Order.new
		@is_placed = false
		@menu = Menu.new

	end

	def show_menu
		dish_1 = Dish.new("Fish and Chips", 15)
		dish_2 = Dish.new("Burger and Fries", 20)
		dish_3 = Dish.new("Lamb Kebab", 18)
		@menu.add(dish_1)
		@menu.add(dish_2)
		@menu.add(dish_3)
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

	def show_receipt
		return @order.show_order
	end

	def show_total_bill
		return @order.grand_total
	end

	def order_status
		return @is_placed
	end

	def place_order(phone_number)
		@is_placed = true
	end

	private

end

takeaway = Takeaway.new
takeaway.add_item("Fish and Chips", 2)
