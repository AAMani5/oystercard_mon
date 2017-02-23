class Oystercard
  attr_reader :balance, :journeys, :journey, :in_journey
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
    @in_journey = false
  end

  def top_up(amount)
    fail "Balance cannot exceed £#{MAX_LIMIT}. Current balance is £#{balance}." if (amount + balance) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Your balance is #{balance}, which is below #{MIN_LIMIT}" if balance < MIN_LIMIT
    deduct(journeys.last.fare) if (!(journeys.empty?) && !(journeys.last.complete?) && in_journey?)
    @in_journey = true
    @journey = Journey.new(entry_station: entry_station)
    @journeys << journey
  end

  def touch_out(exit_station)
    @journey ||= Journey.new(entry_station: nil)
    journey.finish(exit_station)
    @journeys << journey unless journeys.include?(journey)
    @in_journey = false
    deduct(journey.fare)
  end

  def in_journey?
    in_journey
    #!!entry_station
  end

private
  def deduct(amount)
    @balance -= amount
  end

end
