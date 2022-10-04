require_relative 'tokens'
require 'twilio-ruby'

class TextClient
	def initialize()
		credentials = TwilioCredentials.new
		@auth_token = credentials.auth_token
		@account_sid = credentials.account_sid
	end


	def create_client
		client = Twilio::REST::Client.new(@account_sid, @auth_token)
		return client
	end
end