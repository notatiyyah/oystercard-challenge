class Journey
    def initialize(station)
        @entry_station = station
    end

    def end_journey(station)
        @exit_station = station
        journey = generate_journey
        @entry_station = nil
        return journey
    end

    def in_journey?
        not @entry_station.nil?
    end

    private

    def generate_journey
        {"entry_point" => @entry_station, "exit_point" => @exit_station}
    end
end