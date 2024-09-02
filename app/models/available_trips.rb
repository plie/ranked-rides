class AvailableTrips

  attr_accessor :rides, :driver

  def initialize(args)
    # initialize with collection of ride objects and driver object
    @rides = args[:rides]
    @driver = args[:driver]

    Rails.logger.info("rides: #{@rides.count}") #  | #{@rides.inspect}
    Rails.logger.info("driver: #{@driver.inspect}")
  end

  def sorted_available_trips
    trips = []
    rides.each do |ride|
      args = {ride: ride, driver: driver}

      cache_key = "trips/#{ride.start_address}_to_#{ride.destination_address}_with_#{driver.home_address}"

      Rails.cache.fetch(cache_key, expires_in: 3.weeks) do
        Rails.logger.info("Cache miss for #{cache_key}. Fetching from API.")
        trip = Trip.new(args)

        # TODO: consider moving trip hash creation to Trip model
        trips << {
          id: SecureRandom.hex(6),
          start_address: trip.start_address,
          destination: trip.destination_address,
          earnings: trip.earnings,
          score: trip.score
        }
      end.tap do |result|
        Rails.logger.info("Cache hit for #{cache_key}. Returning cached response.") if Rails.cache.exist?(cache_key)
      end
    end
    Rails.logger.info("trips: #{trips.inspect}\n\n\n")
    sorted = trips.sort_by { |trip| trip[:score] }.reverse
    Rails.logger.info("sorted: #{sorted.inspect}\n\n\n")
    sorted
  end
end
