require_relative 'tokens'
require 'twilio-ruby'

class TextComms
	def initialize(twilio_client)

		credentials = TwilioCredentials.new
		@auth_token = credentials.auth_token
		@account_sid = credentials.account_sid
		@from_number = credentials.from_number

		@twilio_client = twilio_client
	end

	def delivery_time
		# Allowing for delivery in within 70mins
		return (Time.now + 4200).strftime("%H:%M")
	end

	def send_text_confirmation(number)
		# client = Twilio::REST::Client.new(@account_sid, @auth_token)
		#client = @requester.new(@account_sid, @auth_token)

		text_body = "Order confirmed! It will be delivered before #{delivery_time}"

		@twilio_client.messages.create(
			from: @from_number,
			to: number,
			body: text_body
		)
	end
end