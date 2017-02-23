class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Balance cannot exceed £#{MAX_LIMIT}. Current balance is £#{balance}." if (amount + balance) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Your balance is #{balance}, which is below #{MIN_LIMIT}" if balance < MIN_LIMIT
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

private
  def deduct(amount)
    @balance -= amount
  end

end
