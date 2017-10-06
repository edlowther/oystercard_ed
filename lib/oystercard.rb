require 'journey'
require 'journeylog'

class Oystercard
  attr_reader :balance, :journeylog

  MAX_VALUE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
  end

  def top_up amount
    raise "Cannot top-up with negative amount" if amount < 0
    raise "Max balance of £#{MAX_VALUE} exceeded" if amount + @balance > MAX_VALUE
    @balance += amount
  end

  def touch_in station
    raise "Must have at least £#{MIN_FARE} on card to travel" if @balance < MIN_FARE
    deduct @journeylog.current_journey.fare if @journeylog.current_journey
    @journeylog.start station
  end

  def touch_out station
    @journeylog.finish station
    deduct @journeylog.journeys[-1].fare
  end

  private
  
  def deduct fare
    @balance -= fare
  end

end
