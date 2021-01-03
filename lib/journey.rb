class Journey
    attr_reader :entry_station, :exit_station, :fare
    @@BASE_COST = 1

    def initialize(station=nil)
        @entry_station = station
        @fare = @@BASE_COST
    end

    def end_journey(station=nil)
        @exit_station = station
        @fare = calculate_fare unless @entry_station.nil? || @exit_station.nil?
    end

    def generate_journey
        {"entry_point" => @entry_station, 
        "exit_point" => @exit_station, 
        "fare" => @fare}
    end

    private

    def calculate_fare
        @@BASE_COST + (@entry_station.zone - @exit_station.zone).abs
        # .abs = |x| so that charge is always positive
    end

end