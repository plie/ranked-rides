# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



class SeedDatabase
  def update_record(obj)
    obj.update!(obj.attributes)
  end

  def add_record(obj)
    begin
      key_one = obj.attributes.values.second.to_s
      key_two = obj.attributes.values.fourth.to_s
      if obj.new_record?
        update_record(obj)
        puts "#{key_one}-#{key_two} was created" if obj.persisted?
      else
        puts "#{key_one}-#{key_two} already exists"
      end
    rescue ActiveRecord::RecordInvalid => e
      puts "Validation failed for #{key_one}-#{key_two}: #{e.record.errors.full_messages.join(", ")}"
    end
  end
end

# driver
driver = {name: "Sandy", home_address: "1105 W 39th St, Austin, TX 78756"}

# rides
rides = []
rides << {description: "Grocery Shop", start_address: "1301 W 24th St, Austin, TX 78705", destination_name: "H-E-B", destination_address: "1000 E 41st St, Austin, TX, 78751"}
rides << {description: "Doctor Visit", start_address: "1500 E 4th St, Austin, TX 78702", destination_name: "St. David's Medical Center", destination_address: "919 E 32nd St, Austin, TX, 78705"}
rides << {description: "Class", start_address: "2200 Nueces St, Austin, TX 78705", destination_name: "UT Austin", destination_address: "110 Inner Campus Drive, Austin, TX, 78705"}
rides << {description: "Car Repair", start_address: "3901 Shoal Creek Blvd, Austin, TX 78756", destination_name: "Austin Auto Repair", destination_address: "5400 Burnet Rd, Austin, TX, 78756"}
rides << {description: "Dental Checkup", start_address: "1901 W Braker Ln, Austin, TX 78758", destination_name: "Braker Lane Dental Care", destination_address: "1010 W Anderson Ln, Austin, TX, 78757"}

rides << {description: "Grocery Shop", start_address: "4502 Shoalwood Ave, Austin, TX 78756", destination_name: "Central Market", destination_address: "4001 N Lamar Blvd, Austin, TX, 78756"}
rides << {description: "Doctor Visit", start_address: "1200 W 38th St, Austin, TX 78705", destination_name: "Austin Regional Clinic", destination_address: "6835 Austin Center Blvd, Austin, TX, 78731"}
rides << {description: "Class", start_address: "306 Nueces St, Austin, TX 78701", destination_name: "ACC Highland", destination_address: "6101 Highland Campus Dr, Austin, TX, 78752"}
rides << {description: "Car Repair", start_address: "5312 Woodrow Ave, Austin, TX 78756", destination_name: "Christian Brothers Automotive", destination_address: "12433 N Lamar Blvd, Austin, TX, 78753"}
rides << {description: "Dental Checkup", start_address: "1805 W Rundberg Ln, Austin, TX 78758", destination_name: "Great Expressions Dental", destination_address: "1301 W 38th St, Austin, TX, 78705"}

rides << {description: "Grocery Shop", start_address: "2906 Aftonshire Way, Austin, TX 78748", destination_name: "Whole Foods Market", destination_address: "4301 W William Cannon Dr, Austin, TX, 78749"}
rides << {description: "Doctor Visit", start_address: "7303 Bennett Ave, Austin, TX 78752", destination_name: "Austin Health Commons", destination_address: "2529 S 1st St, Austin, TX, 78704"}
rides << {description: "Class", start_address: "2408 Leon St, Austin, TX 78705", destination_name: "Austin Community College", destination_address: "1212 Rio Grande St, Austin, TX, 78701"}
rides << {description: "Car Repair", start_address: "9508 W Parmer Ln, Austin, TX 78717", destination_name: "Jiffy Lube", destination_address: "1100 W Parmer Ln, Austin, TX, 78727"}
rides << {description: "Dental Checkup", start_address: "3601 S Congress Ave, Austin, TX 78704", destination_name: "Castle Dental", destination_address: "5300 S MoPac Expy, Austin, TX, 78749"}

rides << {description: "Grocery Shop", start_address: "1114 W 6th St, Austin, Austin, TX 78703", destination_name: "Trader Joe's", destination_address: "211 Walter Seaholm Dr, Austin, TX, 78701"}
rides << {description: "Doctor Visit", start_address: "900 W Cesar Chavez St, Austin, TX 78703", destination_name: "Ascension Seton", destination_address: "1201 W 38th St, Austin, TX, 78705"}
rides << {description: "Class", start_address: "2101 Rio Grande St, Austin, TX 78705", destination_name: "St. Edward's University", destination_address: "3001 S Congress Ave, Austin, TX, 78704"}
rides << {description: "Car Repair", start_address: "8600 N Lamar Blvd, Austin, TX 78753", destination_name: "Lamb's Tire & Automotive", destination_address: "6100 S Congress Ave, Austin, TX, 78745"}
rides << {description: "Dental Checkup", start_address: "3201 Duval Rd, Austin, TX 78759", destination_name: "Smiles by Garcia", destination_address: "2530 Walsh Tarlton Ln, Austin, TX, 78746"}

# create records
seed_class = SeedDatabase.new
driver = Driver.find_or_initialize_by(name: "Sandy")
seed_class.add_record(driver)

rides.each do |ride|
  ride = Ride.find_or_initialize_by(
    description: ride[:description],
    start_address: ride[:start_address],
    destination_name: ride[:destination_name],
    destination_address: ride[:destination_address]
  )
  seed_class.add_record(ride)
end
