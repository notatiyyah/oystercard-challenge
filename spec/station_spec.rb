require 'station'

describe Station do

    it "when created, sets a 'zone' attribute" do
        hackney_central = Station.new(1)
        expect(hackney_central.zone).to eq 1
    end

end