require_relative 'tokens'
require 'twilio-ruby'

class TextComms
	def initialize(to_number)
		@to_number = to_number
		credentials = TwilioCredentials.new
		@auth_token = credentials.auth_token
		@account_sid = credentials.account_sid
		@from_number = credentials.from_number
	end

	def delivery_time
		# Allowing for delivery in within 70mins
		return (Time.now + 4200).strftime("%H:%M")
	end

	def send_text_confirmation
		client = Twilio::REST::Client.new(@account_sid, @auth_token)
		#p client

		text_body = "Order confirmed! It will be delivered before #{delivery_time}"

		client.messages.create(
			from: @from_number,
			to: @to_number,
			body: text_body
		)

		# Fetch last message sent
		messages = client.messages.list(limit: 1)
		message_sid = messages[0].sid
		# Get last message body to compare to text_body
		message_body =  messages[0].body
		# Due to limitation with Twilio trial account
		actual_text_body = "Sent from your Twilio trial account - " + text_body
		# Check last message sent is correctly
		return message_body == actual_text_body

	end
end