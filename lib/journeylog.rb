class JourneyLog

  def initialize(journey_class = {})
    @journey_class = journey_class[:journey_class]
    @journeys_log = []
  end

  def start(entry_station)
    journey = journey_class.new(entry_station: entry_station)
    journeys_log << journey
  end

  def journeys
    journeys_log.dup
  end

  private
  attr_reader :journeys_log, :journey_class
  def current_journey
    @current_journey ||= journey_class.new
  end
end
