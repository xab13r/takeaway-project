require 'dotenv/load' # Just to load environment variable
require_relative 'menu'
require 'twilio-ruby'

# For it to work:
# requester = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])

class Takeaway
  # menu is instance of menu
  def initialize(menu, requester)
    @menu = menu
    @requester = requester
    @order = []
  end

  def show_menu
    @menu.show
  end

  def current_order
    @order
  end

  def add_item(dish_name, quantity)
    # if a dish is on the menu then can be added to the order
    raise 'Quantity must be a number' unless quantity.is_a? Numeric

    dish_to_add = show_menu.find { |item| item[:name] == dish_name }
    if dish_to_add
      @order.push({ name: dish_to_add[:name], quantity: quantity, price: quantity * dish_to_add[:price] })
    else
      raise 'Dish not on the menu'
    end
  end

  def grand_total
    @order.sum { |item| item[:price] }
  end

  def place_order(phone_number)
    # Fail if the the order is empty
    raise 'Order is empty' if @order.empty?

    # Assuming UK phone number, fail if phone is not valid
    if phone_number.length != 14 || !phone_number.start_with?('+44')
      raise 'Please enter a valid phone number'
    else
      message = send_text(phone_number)
    end

    if message == 'queued'
      'Order complete!'
    else
      raise 'An error occurred - Please try again'
    end
  end

  private

  def send_text(to_number)
    delivery_time = (Time.now + 4200).strftime('%H:%M')
    text_body = "Order confirmed! It will be delivered before #{delivery_time}"

    client_messages = @requester.messages
    new_message = client_messages.create(
      from: ENV['TWILIO_FROM_NUMBER'],
      to: to_number,
      body: text_body
    )
    new_message.status
  end
end
