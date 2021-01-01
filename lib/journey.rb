class Journey
    attr_reader :fare

    def initialize(station)
        @entry_station = station
    end

    def end_journey(station)
        @exit_station = station
        @fare = calculate_fare
        generate_journey_then_reset
    end

    def in_journey?
        not @entry_station.nil?
    end

    private

    def generate_journey_then_reset
        journey = {"entry_point" => @entry_station, "exit_point" => @exit_station}
        @entry_station = nil
        return journey
    end

    def calculate_fare
        1
    end
end