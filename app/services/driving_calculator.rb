class DrivingCalculator
  require 'httparty'
  # require 'dotenv-rails'
  # Dotenv.load

  GOOGLE_API_KEY = "AIzaSyD3gUWHVOwhw6K0AWxa7b-9Djl65UhdY5k"
  # GOOGLE_API_KEY = ENV["GOOGLE_API_KEY"] # TODO: fix connection to environment vars
  GOOGLE_MAPS_API_URL = 'https://maps.googleapis.com/maps/api/directions/json'
  KM_TO_MILES_FACTOR = 0.621371.freeze

  def self.get_directions_info(args)
    cache_key = "directions_info/#{args[:start]}_to_#{args[:destination]}"

    Rails.cache.fetch(cache_key, expires_in: 3.weeks) do
      Rails.logger.info("Cache miss for #{cache_key}. Fetching from API.")
      url = "#{GOOGLE_MAPS_API_URL}?origin=#{args[:start]}&destination=#{args[:destination]}&key=#{GOOGLE_API_KEY}"
      response = HTTParty.get(url)
      parse_response(response)
    end.tap do |result|
      Rails.logger.info("Cache hit for #{cache_key}. Returning cached response.") if Rails.cache.exist?(cache_key)
    end
  end

  def self.parse_response(response)
    hashed_response = response.to_h
    kilometers_distance = hashed_response["routes"][0]["legs"][0]["distance"]["value"] # "distance"=>{"text"=>"1.8 mi", "value"=>2927}
    miles = ((kilometers_distance * KM_TO_MILES_FACTOR) / 1000).round(1)
    seconds_duration = hashed_response["routes"][0]["legs"][0]["duration"]["value"] # "duration"=>{"text"=>"5 mins", "value"=>312}
    hours = (seconds_duration / 3600.0).round(1)
    { distance: miles, duration: hours }
  end
end
