require 'journey'

describe Journey do
    let(:station) { double("station") }
    let(:journey) { Journey.new(station) }

    it "returns minimum fare if journey started and ended" do
        journey.end_journey(station)
        expect(journey.fare).to eq 1
    end

    it "sets entry_station to blank if journey started without one" do
        expect{ new_journey = Journey.new }.not_to raise_error
    end
end