class OysterCard
    attr_reader :balance
    attr_reader :in_journey
    
    def initialize
        @balance = 0
        @max_balance = 90
        @in_journey = false
    end

    def top_up(money)
        raise "Exceeded max balance limit" if @balance + money > @max_balance
        @balance += money
    end

    def deduct(money)
        @balance -= money
    end

    def touch_in
        @in_journey = true
    end

    def touch_out
        @in_journey = false
    end

end