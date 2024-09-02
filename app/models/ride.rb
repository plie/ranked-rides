class Ride < ApplicationRecord
  # description: "Doctor Visit", start_address: "1500 E 4th St, Austin, TX 78702", destination_name: "St. David's Medical Center", destination_address: "919 E 32nd St, Austin, TX, 78705"
  # description: "Grocery Shop", start_address: "4502 Shoalwood Ave, Austin, TX 78756", destination_name: "Central Market", destination_address: "4001 N Lamar Blvd, Austin, TX, 78756"

  validates :description, presence: true
  validates :start_address, presence: true
  validates :destination_name, presence: true
  validates :destination_address, presence: true

  def ride_distance
    # the driving_distance from the start address of the ride to the destination address, in miles
    get_directions_info[:distance]
  end

  def ride_duration
    # the amount of time the ride is expected to take, in hours
    get_directions_info[:duration]
  end

  private

  def get_directions_info
    DrivingCalculator.get_directions_info(start: start_address, destination: destination_address)
  end
end
