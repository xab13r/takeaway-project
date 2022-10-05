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
class Dish
	def initialize(name, price)
		# set the instance
	end

	def name
		# returns the dish name
	end

	def price
		# returns the dish price
	end
end
```


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

### Takeaway class

```ruby
class Takeaway
	def initialize # takes a menu and a text client
		# creates a new order
		#
	end

	def show_menu
		# returns a list of all available dishes
	end

	def current_order
		# returns an itemized list of items and quantities
		# in the current order
	end

	def add_item(dish, quantity)
		# adds dish and quantity to the order
	end

	def grand_total
		# returns the grand total for the order
	end

	def place_order(phone_number)
		# phone_number is required for text notification
		# changes status of the order
		# sends text confirmation
	end

	private

	def send_text(to_number)
		# private method to send a text using the Twilio API
		# returns the message status
	end
end
```
