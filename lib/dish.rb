class Dish
  def initialize(name, price)
    if (name.is_a? String) & (price.is_a? Numeric)
      @name = name
      @price = price
    else
      raise 'Please check your input'
    end
  end

  attr_reader :name, :price
end
