
class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @journey = []
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
    # @journey<< {entry_station: @entry_station, exit_station: @exit_station}
  end

  def fare
    return PENALTY_FARE if !entry_station || !exit_station
    MIN_FARE
  end

  def complete?
    true if entry_station && exit_station
  end
end
