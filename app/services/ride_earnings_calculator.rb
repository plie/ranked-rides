class RideEarningsCalculator
  BASE_MILES = 5.freeze
  BASE_MINUTES = 15.freeze
  BASE_EARNING_CENTS = 1200.freeze
  EARNINGS_PER_MILE_CENTS = 150.freeze
  EARNINGS_PER_MINUTE_CENTS = 7.freeze

  def self.ride_earnings_dollars(args)
    earning_for_distance = self.calculate_amount_over_base(args[:distance], BASE_MILES, EARNINGS_PER_MILE_CENTS)
    earnings_for_duration = self.calculate_amount_over_base(args[:duration], BASE_MINUTES, EARNINGS_PER_MINUTE_CENTS)
    cents_earned = (BASE_EARNING_CENTS + earning_for_distance + earnings_for_duration)
    (cents_earned / 100).round(2)
  end

  def self.calculate_amount_over_base(amount, base, earnings)
    beyond_minimim = (amount - base).positive? ? amount - base : 0
    earnings * beyond_minimim
  end
end
