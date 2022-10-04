require 'text_comms'

RSpec.describe TextComms do
	context "after initialization" do
		it "can send a confirmation message with delivery time" do
			fake_twilio = FakeTwilio.new('1','2')
			text_comms = TextComms.new(fake_twilio)
			text_comms.send_text_confirmation("+440700000000")

			expect(fake_twilio.messages.counter_value).to eq 1
		end
	end
end

class FakeTwilio
	def initialize(account_sid, auth_token)
		@fake_messages = FakeMessages.new
		# p "Fake messages:"
		# p @fake_messages
	end

	def messages
		# p "Messages method called"
		# p @fake_messages
		return @fake_messages
	end
end

class FakeMessages
	def initialize
		# Set up a counter to keep track of method calls
		@counter = 0
		# p "FakeMessages initialized"
	end

	def create(from:, to:, body:)
		@counter += 1
		# p "Create method called"
	end

	def counter_value
		# p "Counter method called"
		return @counter
	end
end