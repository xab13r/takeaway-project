class Menu
def initialize
	@menu = Array.new
end

def add(dish, price)
	@menu.push({name: dish, price: price})
end

def show
	fail "No dish present" unless !@menu.empty?
	return @menu
end
end