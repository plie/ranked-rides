class DashController < ApplicationController

  def dash
    @driver = Driver.find_by(name: "Sandy")
    @rides = Ride.all

    # Rails.logger.info("rides: #{@rides.count} | #{@rides.inspect}")
    # Rails.logger.info("driver: #{@driver.inspect}")

    args = {rides: @rides, driver: @driver}
    avail_trips = AvailableTrips.new(args)

    # Rails.logger.info("avail_trips: #{avail_trips.inspect}")

    @ranked_trips = avail_trips.sorted_available_trips

    # Rails.logger.info("@ranked_trips: #{@ranked_trips.inspect}")

    paginated_rides = Kaminari.paginate_array(@ranked_trips).page(params[:page]).per(10)

    render json: {
      rides: paginated_rides,
      pagination: {
        current_page: paginated_rides.current_page,
        next_page: paginated_rides.next_page,
        prev_page: paginated_rides.prev_page,
        total_pages: paginated_rides.total_pages,
        total_rides: paginated_rides.total_count
      }
    }
  end
end