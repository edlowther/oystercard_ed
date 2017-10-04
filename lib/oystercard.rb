class Oystercard
  attr_reader :balance, :entry_station, :history

  MAX_VALUE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @history = []
  end

  def top_up amount
    raise "Cannot top-up with negative amount" if amount < 0
    raise "Max balance of £#{MAX_VALUE} exceeded" if amount + @balance > MAX_VALUE
    @balance += amount
  end

  def touch_in station
    raise "Must have at least £#{MIN_FARE} on card to travel" if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out station
    deduct MIN_FARE
    @history << { :entry_station => entry_station, :exit_station => station }
    @entry_station = nil
  end

  def in_journey?
    @entry_station ? true : false
  end

  private
  def deduct fare
    @balance -= fare
  end

end
