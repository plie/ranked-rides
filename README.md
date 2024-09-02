# README

# Ranked Rides
Ranked Rides is an API that delivers paginated JSON of rides, ranking them from the driver's perspective based on a score calculated as $/hour using the formula:

```ruby
(ride_earnings / (commute_duration + ride_duration))
```
Where earnings are calculated as:
```txt
$12 + $1.50/mile beyond 5 miles + (ride duration) * $0.70 per minute beyond 15 minutes.
```

## Ruby version
```ruby
ruby "3.1.2"
```

## Rails version
```ruby
rails "~> 7.0.2", ">= 7.0.2.2"
```

## System dependencies
- **Rails 7.0.2.2**: The main framework used to build the application.
- **Kaminari**: Used for paginating JSON responses.
- **HTTParty**: For making HTTP requests, specifically to the Google Directions API.
- **RSpec**: For writing and running unit tests.
- **FactoryBot**: For creating test data.
- **Shoulda Matchers**: For additional RSpec matchers.
- **SQLite3**: Used as the database for development and testing.
- **Google Directions API**: For calculating the distance and duration between ride start and destination addresses.


## Configuration
*No additional configuration is required beyond standard Rails setup.*

## Database creation
1. Ensure SQLite3 is installed.
2. Run the following command to create the database:
   ```bash
   rails db:create
   ```

## Database initialization
To initialize the database with the required schema, run:

```bash
rails db:migrate
```

## How to run the test suite
To run the RSpec test suite, execute:

```bash
rspec
```

## Services (job queues, cache servers, search engines, etc.)
- **Caching**: The API uses Rails' built-in caching to store responses from the Google Directions API, minimizing redundant API calls and improving performance.
Additionally, all trip object creation is cached as well.
- **Pagination**: The API uses Kaminari to paginate ride data, delivering 10 rides per page.


## Deployment instructions
1. Clone the repository.
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Set up the database:
   ```bash
   rails db:create db:migrate db:seed
   ```
4. Start the Rails server:
   ```bash
   rails server
   ```
5. Access the API at `http://localhost:3000`


## Sample API response (showing only partial response below)
For this sample project, there are 2 pages of 10 rides per page, for a total of 20 rides.

Note: all addresses are real, but all residential addresses are pulled randomly from Austin, TX. No personal information is used.


```json
{
  "rides": [
    {
      "id": "6a0ce7f56f48",
      "start_address": "1200 W 38th St, Austin, TX 78705",
      "destination": "6835 Austin Center Blvd, Austin, TX, 78731",
      "earnings": 12,
      "score": 120
    },
    {
      "id": "b0acaf8eadd5",
      "start_address": "3901 Shoal Creek Blvd, Austin, TX 78756",
      "destination": "5400 Burnet Rd, Austin, TX, 78756",
      "earnings": 12,
      "score": 120
    },
    {
      "id": "fa88a10d290a",
      "start_address": "2408 Leon St, Austin, TX 78705",
      "destination": "1212 Rio Grande St, Austin, TX, 78701",
      "earnings": 12,
      "score": 60
    },
        {
      "id": "32b0fe39000f",
      "start_address": "2200 Nueces St, Austin, TX 78705",
      "destination": "110 Inner Campus Drive, Austin, TX, 78705",
      "earnings": 12,
      "score": 60
    },
    {
      "id": "dff4606af595",
      "start_address": "900 W Cesar Chavez St, Austin, TX 78703",
      "destination": "1201 W 38th St, Austin, TX, 78705",
      "earnings": 12,
      "score": 60
    }
  ],
    "pagination": {
    "current_page": 1,
    "next_page": 2,
    "prev_page": null,
    "total_pages": 2,
    "total_rides": 20
  }
}
```

## Thoughts as I wrap up
Thank you for the opportunity to build this API. While there is always more to build and improve, I enjoyed the work!
