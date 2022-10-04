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
			text_comms = TextComms.new('+447400048424')
			expect(text_comms.send_text_confirmation).to eq true
		end

	end
end