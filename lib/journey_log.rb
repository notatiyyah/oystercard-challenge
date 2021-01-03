require "journey.rb"

class JourneyLog
    attr_reader :journeys
    def initialize
        @journeys = []
    end

    def start(station, journey=nil)
        save_and_reset(station) unless @current_journey.nil?
        @current_journey = (journey.nil? ? Journey.new(station) : journey.new(station))
    end

    def finish(station)
        @current_journey = Journey.new if @current_journey.nil?
        # creates a new journey if journey 'finishes' without starting
        @current_journey.end_journey(station)
        save_and_reset(station)
    end

    def in_journey?
        not @current_journey.nil?
    end

    def last_journey
        @journeys[-1]
    end

    private

    def generate_journey
        {"entry_point" => @current_journey.entry_station, 
        "exit_point" => @current_journey.exit_station, 
        "fare" => @current_journey.fare}
    end

    def save_and_reset(station)
        @journeys << generate_journey
        @current_journey = nil
    end

end