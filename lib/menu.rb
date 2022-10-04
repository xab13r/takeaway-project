class Menu
def initialize
	@menu = Array.new
end

def add(dish)
	@menu.push({name: dish.name, price: dish.price})
end

def show
	fail "No dish present" unless !@menu.empty?
	return @menu
end
end