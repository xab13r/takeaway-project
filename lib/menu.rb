class Menu
  def initialize
    @menu = []
  end

  def add(dish)
    @menu.push({ name: dish.name, price: dish.price })
  end

  def show
    raise 'No dish present' if @menu.empty?

    @menu
  end
end
