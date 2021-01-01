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
        @current_journey = Journey.new(station)
    end

    def touch_out(station)
        @journeys << @current_journey.end_journey(station)
        deduct(1)
        @current_journey = nil
    end

    def in_journey?
        not @current_journey.nil?
    end

    private

    def deduct(money)
        @balance -= money
    end

end