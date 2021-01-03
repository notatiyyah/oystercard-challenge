class Journey
    attr_reader :entry_station, :exit_station, :fare
    @@DEFAULT_FARE = 1

    def initialize(station=nil)
        @entry_station = station
        @fare = @@DEFAULT_FARE
    end

    def end_journey(station)
        @exit_station = station
        @fare = calculate_fare
    end

    private

    def calculate_fare
        1
    end

end