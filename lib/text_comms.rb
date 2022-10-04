require_relative 'tokens'
require 'net/http'

class TextComms
	def initiate(to_number)
		@to_number = to_number
		credentials = TwilioCredentials.new
		@auth_token = credentials.auth_token
		@account_sid = credentials.account_sid
		@from_number = credentials.from_number
	end

	def send_confirmation_message
		client = Twilio::REST::Client.new(account_sid, auth_token)

		delivery_time = (Time.now + 4200).strftime("%k:%m")

		client.messages.create(
			from: @from_number,
			to: @to_number,
			body: "Order confimerd! It will be delivered before #{delivery_time}"
		)
	end
end