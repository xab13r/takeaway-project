require 'text_comms'

RSpec.describe TextComms do
	context "at the beginning" do
		it "can initialize" do
			text_comms = TextComms.new('+447400048424')
		end

		it "can calculate delivery time accurately" do
			text_comms = TextComms.new('+447400048424')
			expect(text_comms.delivery_time).to eq (Time.now + 4200).strftime("%H:%M")
		end

		it "can send a confirmation message with delivery time" do
			fake_twilio = FakeTwilio.new('1','2')
			text_comms = TextComms.new(fake_twilio)
			text_comms.send_text_confirmation("0700000000")

			expect(fake_twilio.messages.counter_value).to eq 1
			#expect(text_comms.send_text_confirmation).to eq true
		end
	end
end

class FakeTwilio
	def initialize(account_sid, auth_token)
		@fake_messages = FakeMessages.new
		p "Fake messages:"
		p @fake_messages
	end

	def messages
		p "Messages method called"
		p @fake_messages
		return @fake_messages
	end
end

class FakeMessages
	def initialize
		@counter = 0
		p "FakeMessages initialized"
	end

	def create(from:, to:, body:)
		@counter += 1
		p "Create method called"
	end

	def counter_value
		p "Counter method called"
		return @counter
	end
end