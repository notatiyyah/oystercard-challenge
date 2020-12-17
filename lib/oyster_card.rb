class OysterCard
    attr_reader :balance
    attr_reader :in_journey
    
    def initialize
        @balance = 0
        @max_balance = 90
        @in_journey = false
        @min_balance = 1
    end

    def top_up(money)
        raise "Exceeded max balance limit" if @balance + money > @max_balance
        @balance += money
    end

    def touch_in
        raise "Insufficient funds for journey, please top up card" if @balance < 1
        @in_journey = true
    end

    def touch_out
        @in_journey = false
        deduct(1)
    end

    def in_journey?
        @in_journey
    end

    private

    def deduct(money)
        @balance -= money
    end

end