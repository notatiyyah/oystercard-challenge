require 'journey_log'

describe JourneyLog do
    let(:journey) { double("journey") }
    let(:log) { JourneyLog.new(journey) }
    let(:station) { double("station", :zone => 1) }

    before do
        allow(journey).to receive(:new) { journey }
        allow(journey).to receive(:end_journey)
        allow(journey).to receive(:generate_journey) { {"entry_point" => station, "exit_point" => station, "fare" => 1} }
    end
  
    it { is_expected.to respond_to(:journeys) }

    it "is not 'in_journey' when instantiated" do
        expect(log).not_to be_in_journey
    end

    it 'is in_journey when journey starts' do
        log.start(station)
        expect(log).to be_in_journey
    end

    it "sets in_journey to true then false when journey starts and ends" do
        log.start(station)
        expect(log).to be_in_journey
        log.finish(station)
        expect(log).not_to be_in_journey
    end

    it "adds a journey" do
        log.start(station)
        expect { log.finish(station) }.to change{ log.journeys.length }.by(1)
    end

    it "saves user journey into 'journeys' array" do
        entry_point =  double("entry", :zone => 1) 
        exit_point =  double("exit", :zone => 1)
        allow(journey).to receive(:generate_journey) { {"entry_point" => entry_point, "exit_point" => exit_point, "fare" => 1} }
        log.start(entry_point)
        log.finish(exit_point)
        expect(log.last_journey["entry_point"]).to eq entry_point
        expect(log.last_journey["exit_point"]).to eq exit_point
    end

    it "if finish without start, creates new journey" do
        allow(journey).to receive(:generate_journey) { {"entry_point" => nil, "exit_point" => station, "fare" => 1} }
        log.finish(station)
        expect(log.last_journey["entry_point"]).to eq nil
    end

    it "if start without finish, saves then creates new journey" do
        allow(journey).to receive(:generate_journey) { {"entry_point" => station, "exit_point" => nil, "fare" => 1} }
        log.start(station)
        log.start(station)
        expect(log.last_journey["exit_point"]).to eq nil
        log.finish(station)
        expect(log.last_journey["entry_point"]).to eq station
    end

end