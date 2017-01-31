require_relative '../spec_helper'

describe Trip do
  describe "validations" do
    it "is invalid without a duration" do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(start_date: '01/01/2017 14:14',
                         start_station_id: station_1.id,
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         bike_id: bike.id,
                         subscription_id: subscription.id,
                         zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end

    it 'is invalid without a start date' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(duration: 88,
                         start_station_id: station_1.id,
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         bike_id: bike.id,
                         subscription_id: subscription.id,
                         zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end

    it 'is invalid without a start station id' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(duration: 88,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         bike_id: bike.id,
                         subscription_id: subscription.id,
                         zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end

    it 'is invalid without an end date' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_station_id: station_2.id,
                         bike_id: bike.id,
                         subscription_id: subscription.id,
                         zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end

    it 'is invalid without an end station id' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         bike_id: bike.id,
                         subscription_id: subscription.id,
                         zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end

    it 'is invalid without a bike id' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         subscription_id: subscription.id,
                         zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end

    it 'is invalid without a subscription id' do
      Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         bike_id: bike.id,
                         zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end
  end

  describe "dashboard" do
    it "returns the trip with the shortest duration" do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create!(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         subscription_id: subscription.id,
                         bike_id: bike.id,
                         zipcode_id: zipcode.id)
     trip1 = Trip.create!(duration: 77,
                        start_station_id: station_1.id,
                        start_date: '01/01/2017 14:14',
                        end_date: '01/03/2017 15:30',
                        end_station_id: station_2.id,
                        subscription_id: subscription.id,
                        bike_id: bike.id,
                        zipcode_id: zipcode.id)

      expect(Trip.shortest_ride).to eq(trip1.duration)
    end

    it 'returns the trip with the longest duration' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create!(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         subscription_id: subscription.id,
                         bike_id: bike.id,
                         zipcode_id: zipcode.id)
     trip1 = Trip.create!(duration: 77,
                        start_station_id: station_1.id,
                        start_date: '01/01/2017 14:14',
                        end_date: '01/03/2017 15:30',
                        end_station_id: station_2.id,
                        subscription_id: subscription.id,
                        bike_id: bike.id,
                        zipcode_id: zipcode.id)

      expect(Trip.longest_ride).to eq(trip.duration)
    end

    it 'returns the average duration of all trips' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create!(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         subscription_id: subscription.id,
                         bike_id: bike.id,
                         zipcode_id: zipcode.id)
     trip1 = Trip.create!(duration: 77,
                        start_station_id: station_1.id,
                        start_date: '01/01/2017 14:14',
                        end_date: '01/03/2017 15:30',
                        end_station_id: station_2.id,
                        subscription_id: subscription.id,
                        bike_id: bike.id,
                        zipcode_id: zipcode.id)

      expect(Trip.average_duration).to eq(82.5)
    end

    it 'returns the date with the highest trip occurrence' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create!(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         subscription_id: subscription.id,
                         bike_id: bike.id,
                         zipcode_id: zipcode.id)
     trip1 = Trip.create!(duration: 77,
                        start_station_id: station_1.id,
                        start_date: '01/01/2017 14:14',
                        end_date: '01/03/2017 15:30',
                        end_station_id: station_2.id,
                        subscription_id: subscription.id,
                        bike_id: bike.id,
                        zipcode_id: zipcode.id)
    trip1 = Trip.create!(duration: 77,
                       start_station_id: station_1.id,
                       start_date: '01/04/2017 14:14',
                       end_date: '01/03/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    require 'pry'; binding.pry

      expect(Trip.busiest_day).to eq('1/1/2017')
    end
  end
end
