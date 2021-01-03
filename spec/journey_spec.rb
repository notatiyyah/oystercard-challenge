require 'journey'

describe Journey do
    let(:journey) { Journey.new(station) }
    let(:station) { double("station", :zone => 1) }

    it "sets entry_station to blank if journey started without one" do
        expect{ new_journey = Journey.new }.not_to raise_error
    end

    it "sets exit_station to blank if journey ended without one" do
        expect{ journey.end_journey }.not_to raise_error
    end

    describe "fare calculation" do
        
        it "charges £1 for travel within the same zone" do
            zone_2_station = double("station_2", :zone => 2)
            short_journey = Journey.new(zone_2_station)
            short_journey.end_journey(zone_2_station)
            expect(short_journey.fare).to eq 1
        end

        it "charges £4 for a journey from zone 4 to 1" do
            zone_4_station = double("station_4", :zone => 4)
            journey_in = Journey.new(zone_4_station)
            journey_in.end_journey(station)
            expect(journey_in.fare).to eq 4  
        end

        it "charges £4 for a journey from zone 1 to 4" do
            zone_4_station = double("station_4", :zone => 4)
            journey_out = Journey.new(station)
            journey_out.end_journey(zone_4_station)
            expect(journey_out.fare).to eq 4  
        end

    end
end