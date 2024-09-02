class GoogleDirections
  # TODO: fix connection to this file - not available to other services
  GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
  GOOGLE_MAPS_API_URL = 'https://maps.googleapis.com/maps/api/directions/json'
  KM_TO_MILES_FACTOR = 0.621371.freeze

  def self.get_directions_info(args)
    url = "#{GOOGLE_MAPS_API_URL}?origin=#{args[:origin]}&destination=#{args[:destination]}&key=#{GOOGLE_API_KEY}"
    response = HTTParty.get(url)
    Rails.logger.info("Google response: #{response}")
    parse_response(response)
  rescue NoMethodError => e
    Rails.logger.error("Error parsing Google Directions API response: #{e.message}")
    { distance: nil, duration: nil }
  end
  end

  def self.parse_response(response)
    hashed_response = response.to_h
    kilometers_distance = hashed_response["routes"][0]["legs"][0]["distance"]["value"] # 57824 (/1000) = 57.824 km / text: 35.9 miles
    miles = (kilometers_distance / KM_TO_MILES_FACTOR)
    seconds_duration = hashed_response["routes"][0]["legs"][0]["duration"]["value"]
    hours = (seconds_duration / 60) / 60 # hours = (seconds_duration / 3600.0).round(2)
    { distance: miles, duration: hours }
  rescue NoMethodError => e
    Rails.logger.error("Error parsing Google Directions API response: #{e.message}")
    { distance: nil, duration: nil }
  end
  end
end
