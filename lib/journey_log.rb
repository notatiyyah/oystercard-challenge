require "journey.rb"

class JourneyLog
    attr_reader :journeys
    def initialize
        @journeys = []
    end

    def start(station, journey=nil)
        if in_journey?
            Journey.new(station)
            save_and_reset
        end
        @current_journey = (journey.nil? ? Journey.new(station) : journey.new(station))
    end

    def finish(station)
        @current_journey = Journey.new if @current_journey.nil?
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