class RideScoreCalculator
  def self.ride_score(args)
    ride_earnings = args[:ride_earnings]
    commute_duration = args[:commute_duration]
    ride_duration = args[:ride_duration]

    (ride_earnings / (commute_duration + ride_duration)).round(2)
  end
end
