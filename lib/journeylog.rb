require_relative 'journey'

class JourneyLog
  attr_reader :journey_class, :current_journey, :journeys
  def initialize journey_class = Journey
    @journey_class = journey_class
    @journeys = []
  end

  def start station
    @current_journey = @journey_class.new
    @current_journey.start station
    @journeys << @current_journey
  end

  def finish station
    @current_journey = Journey.new if !@current_journey
    @current_journey.finish station
    @journeys << @current_journey if !@journeys.include? @current_journey
    @current_journey = nil
  end
end
