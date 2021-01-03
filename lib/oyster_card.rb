require "journey_log"

class OysterCard
    attr_reader :balance

    @@MAX_BALANCE = 90
    @@MIN_BALANCE = 1
    @@PENALTY_CHARGE = 6

    def initialize(log=nil)
        @balance = 0
        @journey_log = (log.nil? ? JourneyLog.new : log)
    end

    def top_up(money)
        raise "Exceeded max balance limit" if @balance + money > @@MAX_BALANCE
        @balance += money
    end

    def touch_in(station)
        raise "Insufficient funds for journey, please top up card" if @balance < @@MIN_BALANCE
        was_in_journey_already = in_journey?
        @journey_log.start(station)
        deduct(calculate_fare) if was_in_journey_already
        # have to save in_journey status before starting journey because starting journey changes in_journey state
    end

    def touch_out(station)
        @journey_log.finish(station)
        deduct(calculate_fare)
    end

    def in_journey?
        @journey_log.in_journey?
    end

    def journeys
        @journey_log.journeys
    end

    private

    def deduct(money)
        @balance -= money
    end

    def calculate_if_penalty(journey)
        journey["entry_point"].nil? || journey["exit_point"].nil? ? 5 : 0
        # if either entry_station or exit_station are empty, charges £6 penalty
    end

    def calculate_fare
        journey = @journey_log.last_journey
        calculate_if_penalty(journey) + journey["fare"]
        # total charge = penalty + base fare
    end
    
end