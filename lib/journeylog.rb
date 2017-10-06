require_relative 'journey'

class JourneyLog
  attr_reader :current_journey

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
    @current_journey = @journey_class.new if !@current_journey
    @current_journey.finish station
    @journeys << @current_journey if !@journeys.include? @current_journey
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end
end
