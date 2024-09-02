class Trip
  attr_accessor :ride, :driver, :commute_distance, :commute_duration, :earnings, :score

  delegate :description, :start_address, :destination_address, :destination_name, :ride_duration, :ride_distance, to: :ride
  delegate :home_address, to: :driver, prefix: true

  def initialize(args)
    # initialize with a ride object and a driver object
    @ride = args[:ride]
    @driver = args[:driver]
    @commute_distance = commute_distance
    @commute_duration = commute_duration
    @earnings = ride_earnings
    @score = ride_score_as_dollar_per_hour
  end

  def commute_distance
     get_directions_info[:distance]
  end

  def commute_duration
    get_directions_info[:duration]
  end

  def get_directions_info
    DrivingCalculator.get_directions_info(start: driver_home_address, destination: start_address)
  end

  def ride_earnings
    RideEarningsCalculator.ride_earnings_dollars(duration: ride_duration, distance: ride_distance)
  end

  def ride_score_as_dollar_per_hour
    args = {ride_earnings: earnings, commute_duration: commute_duration, ride_duration: ride_duration}
    RideScoreCalculator.ride_score(args)
  end
end
