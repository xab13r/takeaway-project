require_relative 'tokens'
require 'twilio-ruby'

class TextComms
	def initialize(twilio_client)

		credentials = TwilioCredentials.new
		@from_number = credentials.from_number
		# The class is taking a Twilio client already initialized with the correct parameters
		@twilio_client = twilio_client
	end

	def send_text_confirmation(number)
		# Original API call
		# client = Twilio::REST::Client.new(@account_sid, @auth_token)

		delivery_time = (Time.now + 4200).strftime("%H:%M")
		text_body = "Order confirmed! It will be delivered before #{delivery_time}"

		@twilio_client.messages.create(
			from: @from_number,
			to: number,
			body: text_body
		)
	end
end