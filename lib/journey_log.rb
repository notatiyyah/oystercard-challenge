require "journey.rb"

class JourneyLog
    attr_reader :journeys
    @@double_journey = ->(station=nil) { return @journey.nil? ? Journey.new(station) : @journey.new(station) }
    # If there is a double, use that, else use actual class
    def initialize(journey=nil)
        @journeys = []
        @journey = journey
        # Use double for testing
    end

    def start(station)
        save_and_reset if in_journey?
        @current_journey = @@double_journey.call(station)
    end

    def finish(station)
        @current_journey = @@double_journey.call if @current_journey.nil?
        # creates a new journey if journey 'finishes' without starting
        @current_journey.end_journey(station)
        save_and_reset
    end

    def in_journey?
        not @current_journey.nil?
    end

    def last_journey
        @journeys[-1]
    end

    private

    def save_and_reset
        @journeys << @current_journey.generate_journey
        @current_journey = nil
    end

end