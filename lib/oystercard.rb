class Oystercard
  attr_reader :balance, :in_journey, :journey_log
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1

  def initialize(journey_log = JourneyLog.new(journey_class: Journey))
    @balance = 0
    @journey_log = journey_log
    @in_journey = false
  end

  def top_up(amount)
    fail "Balance cannot exceed £#{MAX_LIMIT}. Current balance is £#{balance}." if (amount + balance) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Your balance is #{balance}, which is below #{MIN_LIMIT}" if balance < MIN_LIMIT
    deduct(journey_log.journeys.last.fare) if (!(journey_log.journeys.empty?) && !(journey_log.journeys.last.complete?) && in_journey?)
    @in_journey = true
    journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    fare = @journey_log.finish(exit_station)
    deduct(fare)
    @in_journey = false
  end

  def in_journey?
    in_journey
    #!!entry_station
  end

  def history
    journey_log.journeys
  end

private
  def deduct(amount)
    @balance -= amount
  end

end
