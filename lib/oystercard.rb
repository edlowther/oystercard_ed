require 'journey'

class Oystercard
  attr_reader :balance, :history, :current_journey

  MAX_VALUE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def top_up amount
    raise "Cannot top-up with negative amount" if amount < 0
    raise "Max balance of £#{MAX_VALUE} exceeded" if amount + @balance > MAX_VALUE
    @balance += amount
  end

  def touch_in station
    raise "Must have at least £#{MIN_FARE} on card to travel" if @balance < MIN_FARE
    deduct @current_journey.fare if @current_journey
    @current_journey = Journey.new
    @current_journey.start station
    @history << @current_journey
  end

  def touch_out station
    @current_journey = Journey.new if !@current_journey
    @current_journey.finish station
    deduct @current_journey.fare
    @history << @current_journey if !@history.include? @current_journey
    @current_journey = nil
  end

  private
  def deduct fare
    @balance -= fare
  end

end
