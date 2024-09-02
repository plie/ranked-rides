class DashController < ApplicationController

  def dash
    @driver = Driver.find_by(name: "Sandy")
    @rides = Ride.all

    args = {rides: @rides, driver: @driver}
    avail_trips = AvailableTrips.new(args)

    @ranked_trips = avail_trips.sorted_available_trips

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