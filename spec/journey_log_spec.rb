require 'journey_log'

describe JourneyLog do
    let(:log) { JourneyLog.new }
    let(:station) { double("station", :zone => 1) }
  
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
        log.start(entry_point)
        log.finish(exit_point)
        expect(log.last_journey["entry_point"]).to eq entry_point
        expect(log.last_journey["exit_point"]).to eq exit_point
    end

    it "if finish without start, creates new journey" do
        log.finish(station)
        expect(log.last_journey["entry_point"]).to eq nil
    end

    it "if start without finish, saves then creates new journey" do
        log.start(station)
        log.start(station)
        expect(log.last_journey["exit_point"]).to eq nil
        log.finish(station)
        expect(log.last_journey["entry_point"]).to eq station
    end

end