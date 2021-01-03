require "oyster_card"

describe OysterCard do
    let(:oyster) { OysterCard.new }
    let(:station) { double("station") }
    let(:empty_oyster) { OysterCard.new }

    before do
        oyster.top_up(20)
    end

    it { is_expected.to respond_to(:balance) }
    it { is_expected.to respond_to(:top_up) }

    it "sets the balance to 0 when instantiated" do
        expect(empty_oyster.balance).to eq 0
    end

    it "can be topped up by £5" do
        expect { oyster.top_up(5) }.to change{ oyster.balance }.by(5)
    end

    it "raises an error when trying to top up over £90" do
        expect { empty_oyster.top_up(91) }.to raise_error("Exceeded max balance limit")
    end

    it "raises an error if user has less than minimum amount in card when touching in" do
        expect { empty_oyster.touch_in(station) }.to raise_error("Insufficient funds for journey, please top up card")
    end

    it "deducts £1 for trip when user touches out" do
        oyster.touch_in(station)
        expect { oyster.touch_out(station) }.to change{ oyster.balance }.by(-1)
    end

    it "charges penalty charge of 6 if touch_out without touch_in" do
        expect { oyster.touch_out(station) }.to change{ oyster.balance }.by(-6)
    end

    it "charges penalty charge of 6 if touch_in without touch_out from previous journey" do
        oyster.touch_in(station)
        expect { oyster.touch_in(station) }.to change{ oyster.balance }.by(-6)
    end
end