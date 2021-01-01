require 'journey'

describe Journey do
    let(:station) { double("station") }
    let(:journey) {Journey.new(station)}
    
    it "is is 'in_journey' when instantiated" do
        expect(journey).to be_in_journey
    end

    it "sets in_journey to true then false when created then end_journey" do
        expect(journey).to be_in_journey
        journey.end_journey(station)
        expect(journey).not_to be_in_journey
    end

    it "returns journey info when end_journey" do
        entry_point = double("entry")
        exit_point = double("exit")
        new_journey = Journey.new(entry_point)
        total_journey = new_journey.end_journey(exit_point)
        expect(total_journey["entry_point"]).to eq entry_point
        expect(total_journey["exit_point"]).to eq exit_point
    end

    it "returns minimum fare if journey started and ended" do
        journey.end_journey(station)
        expect(journey.fare).to eq 1
    end
end