class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    raise "Exceeded maximum limit of £#{MAX_BALANCE}" if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey.entry_station != nil
  end

  def touch_in(entry_station)
    raise "Insufficient balance, cannot touch in: please top up" unless balance >= MIN_FARE
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journey.end(exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
