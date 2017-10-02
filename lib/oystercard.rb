class Oystercard
  attr_reader :balance, :in_journey

  MAX_VALUE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up amount
    raise "Cannot top-up with negative amount" if amount < 0
    raise "Max balance of £#{MAX_VALUE} exceeded" if amount + @balance > MAX_VALUE
    @balance += amount
  end

  def deduct fare
    @balance -= fare
  end

  def touch_in
    @in_journey = true
  end
end
