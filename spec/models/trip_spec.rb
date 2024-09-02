require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:ride) { build(:ride) }
  let(:driver) { build(:driver) }
  let(:trip) { described_class.new(ride: ride, driver: driver) }

  describe 'initialization' do
    it 'initializes with a ride and a driver' do
      expect(trip.ride).to eq(ride)
      expect(trip.driver).to eq(driver)
    end

    it 'initializes commute_distance and commute_duration' do
      expect(trip.commute_distance).to be_a(Float)
      expect(trip.commute_duration).to be_a(Float)
    end
  end

  describe '#earnings' do
    it 'calculates ride earnings' do
      allow(RideEarningsCalculator).to receive(:ride_earnings_dollars).with(
        duration: ride.ride_duration,
        distance: ride.ride_distance
      ).and_return(25.34)

      expect(trip.earnings).to eq(25.34)
    end
  end

  describe '#score' do
    it 'calculates ride score as $ per hour' do
      args = {
        ride_earnings: trip.earnings,
        commute_duration: trip.commute_duration,
        ride_duration: ride.ride_duration
      }

      allow(trip).to receive(:earnings).and_return(12.0)
      allow(trip).to receive(:commute_duration).and_return(0.1)
      allow(RideScoreCalculator).to receive(:ride_score).with(args).and_return(0.2)

      expect(trip.score).to eq(40.0)
    end
  end

  describe '#commute_distance' do
    it 'calculates commute distance using DrivingCalculator' do
      allow(DrivingCalculator).to receive(:get_directions_info).and_return(distance: 1.8, duration: 0.1)

      expect(trip.send(:commute_distance)).to eq(1.8)
    end
  end

  describe '#commute_duration' do
    it 'calculates commute duration using DrivingCalculator' do
      allow(DrivingCalculator).to receive(:get_directions_info).and_return(distance: 10.0, duration: 0.5)

      expect(trip.send(:commute_duration)).to eq(0.5)

    end
  end

  describe 'private methods' do
    describe '#ride_earnings' do
      it 'calculates earnings using RideEarningsCalculator' do
        allow(RideEarningsCalculator).to receive(:ride_earnings_dollars).and_return(60.0)

        expect(trip.send(:ride_earnings)).to eq(60.0)
      end
    end

    describe '#ride_score_as_dollar_per_hour' do
      it 'calculates score using RideScoreCalculator' do
        allow(trip).to receive(:ride_earnings).and_return(50.0)
        allow(trip).to receive(:commute_duration).and_return(1.5)
        allow(RideScoreCalculator).to receive(:ride_score).and_return(25.0)

        expect(trip.send(:ride_score_as_dollar_per_hour)).to eq(25.0)
      end
    end
  end
end