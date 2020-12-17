class OysterCard
    attr_reader :balance, :entry_station, :journeys

    def initialize
        @balance = 0
        @max_balance = 90
        @min_balance = 1
        @journeys = []
    end

    def top_up(money)
        raise "Exceeded max balance limit" if @balance + money > @max_balance
        @balance += money
    end

    def touch_in(station)
        raise "Insufficient funds for journey, please top up card" if @balance < 1
        @entry_station = station
    end

    def touch_out(station)
        save_journey(station)
        deduct(1)
        @entry_station = nil
    end

    def in_journey?
        @entry_station != nil
    end

    private

    def deduct(money)
        @balance -= money
    end

    def save_journey(exit_station)
        journeys << {"entry_point" => @entry_station, "exit_point" => exit_station}
    end

end