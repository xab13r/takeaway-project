class Dish
  def initialize(name, price)
    if (name.is_a? String) & (price.is_a? Numeric)
      @name = name
      @price = price
    else
      fail "Please check your input"
    end
  end

  def name
    return @name
  end

  def price
    return @price
  end
end
