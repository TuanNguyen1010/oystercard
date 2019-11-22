class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey = []
  end

  def top_up(amount)
    raise "Exceeded maximum limit of £#{MAX_BALANCE}" if (balance + amount) > MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    raise "Card already touched in" if in_journey?

    raise "Insufficient balance, cannot touch in: please top up" unless balance >= MIN_FARE
    @entry_station = entry_station
    in_journey?
  end

  def touch_out(exit_station)
    raise "Card not touched in" unless in_journey?
    deduct(MIN_FARE)
    @exit_station = exit_station
    @journey<< {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
    in_journey?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
