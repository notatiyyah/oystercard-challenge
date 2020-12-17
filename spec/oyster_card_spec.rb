require "oyster_card"

describe OysterCard do
    let(:oyster) {OysterCard.new}
    it { is_expected.to respond_to(:balance) }
    it { is_expected.to respond_to(:top_up) }

    it "sets the balance to 0 when instantiated" do
        expect(oyster.balance).to eq 0
    end

    it "can be topped up by £5" do
        oyster.top_up(5)
        expect(oyster.balance).to eq 5
    end

    it "raises an error when trying to top up over £90" do
        expect { oyster.top_up(91) }.to raise_error("Exceeded max balance limit")
    end

    it "sets 'in_journey' to false when instantiated" do
        expect(oyster.in_journey?).to eq false
    end

    it 'sets in_journey to true when the user touches in' do
        oyster.top_up(20)
        oyster.touch_in
        expect(oyster.in_journey?).to eq true
    end

    it "sets in_journey to true then false when user touches in and out" do
        oyster.top_up(20)
        oyster.touch_in
        expect(oyster.in_journey?).to eq true
        oyster.touch_out
        expect(oyster.in_journey?).to eq false
    end

    it "raises an error if user has less than minimum amount in card when touching in" do
        expect { oyster.touch_in }.to raise_error("Insufficient funds for journey, please top up card")
    end

    it "deducts £1 for trip when user touches out" do
        oyster.top_up(20)
        oyster.touch_in
        expect { oyster.touch_out }.to change{ oyster.balance }.by(-1)
    end
end