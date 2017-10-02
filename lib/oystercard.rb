class Oystercard
  attr_reader :balance

  MAX_VALUE = 90

  def initialize
    @balance = 0
  end

    def top_up amount
    raise "Max balance of £#{MAX_VALUE} exceeded" if amount + @balance > MAX_VALUE
    @balance += amount
  end
end
