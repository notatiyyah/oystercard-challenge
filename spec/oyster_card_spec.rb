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
end