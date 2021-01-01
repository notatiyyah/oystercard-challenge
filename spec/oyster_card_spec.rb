require "oyster_card"

describe OysterCard do
    let(:oyster) {OysterCard.new}
    let(:station) { double("station") }

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

    it "is not 'in_journey' when instantiated" do
        expect(oyster).not_to be_in_journey
    end

    it 'is in_journey when the user touches in' do
        oyster.top_up(20)
        oyster.touch_in(station)
        expect(oyster).to be_in_journey
    end

    it "sets in_journey to true then false when user touches in and out" do
        oyster.top_up(20)
        oyster.touch_in(station)
        expect(oyster).to be_in_journey
        oyster.touch_out(station)
        expect(oyster).not_to be_in_journey
    end

    it "raises an error if user has less than minimum amount in card when touching in" do
        expect { oyster.touch_in(station) }.to raise_error("Insufficient funds for journey, please top up card")
    end

    it "deducts £1 for trip when user touches out" do
        oyster.top_up(20)
        oyster.touch_in(station)
        expect { oyster.touch_out(station) }.to change{ oyster.balance }.by(-1)
    end

    it "saves user journey into 'journeys' array" do
        entry_point = double("entry")
        exit_point = double("exit")
        oyster.top_up(20)
        oyster.touch_in(entry_point)
        oyster.touch_out(exit_point)
        journey = oyster.journeys[0]
        expect(journey["entry_point"]).to eq entry_point
        expect(journey["exit_point"]).to eq exit_point
    end
end