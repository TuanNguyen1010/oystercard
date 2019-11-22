
class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    return 6 if !@entry_station || !@exit_station
    1
  end

  def complete?
    true if entry_station && exit_station
  end
end
