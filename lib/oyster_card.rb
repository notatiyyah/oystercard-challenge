class OysterCard
    attr_reader :balance, :journeys

    @@MAX_BALANCE = 90
    @@MIN_BALANCE = 1
    @@PENALTY_CHARGE = 6

    def initialize
        @balance = 0
        @journeys = []
    end

    def top_up(money)
        raise "Exceeded max balance limit" if @balance + money > @@MAX_BALANCE
        @balance += money
    end

    def touch_in(station)
        raise "Insufficient funds for journey, please top up card" if @balance < @@MIN_BALANCE
        @current_journey = Journey.new(station)
    end

    def touch_out(station)
        set_journey(station)
        deduct_correct_fare
        @current_journey = nil
    end

    def in_journey?
        not @current_journey.nil?
    end

    private

    def deduct(money)
        @balance -= money
    end

    def deduct_correct_fare
        deduct(@current_journey.nil? ? @@PENALTY_CHARGE : @current_journey.fare)
    end

    def set_journey(exit_point)
        @journeys << (@current_journey.nil? ? {"entry_point" => nil, "exit_point" => exit_point} : @current_journey.end_journey(exit_point))
    end
end