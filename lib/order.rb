class Order
	def initialize
		@order = Array.new
	end

	def add(dish, quantity)
		@order.push({name: dish[:name], quantity: quantity, price: quantity * dish[:price]})
	end

	def show_order
		return @order
	end

	def grand_total
		return @order.sum {|item| item[:price]}
	end

end