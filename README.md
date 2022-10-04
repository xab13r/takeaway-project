# Takeaway Project

## User Stories

> As a customer
> So that I can check if I want to order something
> I would like to see a list of dishes with prices.
>
> As a customer
> So that I can order the meal I want
> I would like to be able to select some number of several available dishes.
>
> As a customer
> So that I can verify that my order is correct
> I would like to see an itemized receipt with a grand total.
>
> As a customer
> So that I am reassured that my order will be delivered on time
> I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.

## Class System Design

### Menu class
```ruby
class Menu
	def initialize
	end

	def add(dish, price)
		# add a dish to the menu
		# returns nothing
	end

	def show
		# returns a list of dishes available
	end
end
```

### Order class
```ruby
class Order
	def initialize
	end

	def is_placed?
		# return true if the order has been placed
	end

	def show_order
		# return itemized receipt
	end

	def grand_total
		# return order grand total
	end
end
```

### Takeaway class

```ruby
class Takeaway
	def initialize
		# creates a new order
	end

	def show_menu
		# returns a list of all available dishes
	end

	def add_item(dish, quantity)
		# adds dish and quantity to the order
	end

	def show_receipt
		# returns itemized receipt and grand total
	end

	def confirm_order(phone_number)
		# phone_number is required for text notification
		# changes status of the order
		# sends text confirmation
	end

	private

	dish_1 = Dish.new("test dish", 20)
	dish_2 = Dish.new("test dish 2", 40)
	dish_3 = Dish.new("test dish 3", 30)

	def create_menu(menu)
		# private method to create and return menus
	end
end
```

### TextComms class

```ruby
class TextComms(phone_number)
	def initialize
		# initialized with phone number
	end

	def check_order(order)
		# double check if the order has been confirmed
	end

	def send_text
	end
```
