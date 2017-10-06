class Journey
  attr_reader :entry_station, :exit_station
  def initialize
    @entry_station = false
    @exit_station = false
  end

  def start station
    @entry_station = station
  end

  def finish station
    @exit_station = station
  end

  def fare
    complete? ? 1 + (exit_station.zone - entry_station.zone).abs : 6
  end

  def complete?
    @entry_station and @exit_station
  end
end
