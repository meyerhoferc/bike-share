require_relative '../spec_helper'

describe Bike do
  describe "validations" do
    it "is invalid without a number" do
      bike = Bike.create()

      expect(bike).to_not be_valid
    end
  end

  describe ".most_ridden" do
    it 'returns the most ridden bike' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      bike2 = Bike.create(bike_number: 38)
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
                        bike_id: bike2.id,
                        zipcode_id: zipcode.id)
     trip1 = Trip.create!(duration: 77,
                       start_station_id: station_1.id,
                       start_date: '01/04/2017 14:14',
                       end_date: '01/03/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike2.id,
                       zipcode_id: zipcode.id)

      expect(Bike.most_ridden).to eq('Bike 38 had 2 rides')
    end
  end

  describe '.least_ridden' do
    it 'returns the least ridden bike' do
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      bike2 = Bike.create(bike_number: 38)
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
                        bike_id: bike2.id,
                        zipcode_id: zipcode.id)
     trip1 = Trip.create!(duration: 77,
                       start_station_id: station_1.id,
                       start_date: '01/04/2017 14:14',
                       end_date: '01/03/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike2.id,
                       zipcode_id: zipcode.id)

      expect(Bike.least_ridden).to eq('Bike 28 had 1 ride')
    end
  end
end
