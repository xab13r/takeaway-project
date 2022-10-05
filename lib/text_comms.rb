require_relative 'tokens'
require 'twilio-ruby'

class TextComms
	def initialize(twilio_client, to_number)

		credentials = TwilioCredentials.new
		@from_number = credentials.from_number
		# The class is taking a Twilio client already initialized with the correct parameters
		@twilio_client = twilio_client
		@to_number = to_number
	end

	def send_text
		# Original API call
		# client = Twilio::REST::Client.new(@account_sid, @auth_token)

		delivery_time = (Time.now + 4200).strftime("%H:%M")
		text_body = "Order confirmed! It will be delivered before #{delivery_time}"

		client_messages = @twilio_client.messages
		new_message = client_messages.create(
			from: @from_number,
			to: @to_number,
			body: text_body
		)
		return new_message.status
	end
end