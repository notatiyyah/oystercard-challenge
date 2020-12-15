class OysterCard
    attr_reader :balance
    
    def initialize
        @balance = 0
        @max_balance = 90
    end

    def top_up(money)
        raise "Exceeded max balance limit" if @balance + money > @max_balance
        @balance += money
    end

    def deduct(money)
        @balance -= money
    end
end