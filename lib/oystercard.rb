class Oystercard
  attr_reader :balance

  MAX_VALUE = 90
  MIN_FARE = 1

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
    raise "Must have at least £#{MIN_FARE} on card to travel" if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    @balance -= MIN_FARE
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
