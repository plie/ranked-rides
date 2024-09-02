require 'rails_helper'

RSpec.describe Ride, type: :model do

  describe 'validations' do
    # verbose without shoulda gem:
    it 'is valid with valid attributes' do
      ride = Ride.new(description: 'Doctor Visit', start_address: '1500 E 4th St, Austin, TX 78702', destination_name: "St. David's Medical Center", destination_address: '919 E 32nd St, Austin, TX 78705')
      expect(ride).to be_valid
    end

    it 'is not valid without a description' do
      ride = Ride.new(start_address: '1500 E 4th St, Austin, TX 78702', destination_name: "St. David's Medical Center", destination_address: '919 E 32nd St, Austin, TX 78705')
      expect(ride).not_to be_valid
      expect(ride.errors[:description]).to include("can't be blank")
    end

    # succinct with shoulda gem:
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_address) }
    it { should validate_presence_of(:destination_name) }
    it { should validate_presence_of(:destination_address) }
  end

  describe '#ride_distance' do
    let(:ride) { Ride.new(description: 'Doctor Visit', start_address: '1500 E 4th St, Austin, TX 78702', destination_name: "St. David's Medical Center", destination_address: '919 E 32nd St, Austin, TX 78705') }

    it 'returns the correct driving distance in miles' do
      allow(DrivingCalculator).to receive(:get_directions_info).and_return(distance: 10.0, duration: 0.5)

      expect(ride.ride_distance).to eq(10.0)
    end
  end

  describe '#ride_duration' do
    let(:ride) { Ride.new(description: 'Grocery Shop', start_address: '4502 Shoalwood Ave, Austin, TX 78756', destination_name: 'Central Market', destination_address: '4001 N Lamar Blvd, Austin, TX 78756') }

    it 'returns the correct driving duration in hours' do
      allow(DrivingCalculator).to receive(:get_directions_info).and_return(distance: 10.0, duration: 0.5)

      expect(ride.ride_duration).to eq(0.5)
    end
  end
end
