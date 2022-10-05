require 'text_comms'

RSpec.describe TextComms do
	context "after initialization" do
		it "can send a confirmation message with delivery time" do
			# Using Doubles
			# new_message is an object with a status "queued"
			new_message = double(:message, status: 'queued')

			# client_messages is an object with a create method
			client_messages = double(:client_messages, create: new_message)
			# twilio_client is an object with a messages method
			twilio_client = double(:twilio_client, messages: client_messages)

			expect(new_message).to receive(:status).and_return('queued')

			text_comms = TextComms.new(twilio_client, '+447000000000')
			expect(text_comms.send_text).to eq "queued"
		end
	end
end