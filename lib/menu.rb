class Menu
def initialize
	@menu = Array.new
end

def add(dish, price)
	if price.is_a? Numeric
		@menu.push({name: dish, price: price})
	else
		fail "Price must be a number"
	end
end

def show
	fail "No dish present" unless !@menu.empty?
	return @menu
end
end