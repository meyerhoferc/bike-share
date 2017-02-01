require_relative '../spec_helper'
require 'faker'

describe Station do
  describe "validations" do
    it "invalid without a name" do
      station = Station.create(dock_count: 22, city_id: 3, installation_date: "01/01/2017")

      expect(station).to_not be_valid
    end

    it "invalid without a dock count" do
      station = Station.create(name: "Big Deal", city_id: 3, installation_date: "01/01/2017")

      expect(station).to_not be_valid
    end

    it "invalid without a city_id" do
      station = Station.create( name: "Art Center", dock_count: 22, installation_date: "01/01/2017")

      expect(station).to_not be_valid
    end

    it "invalid without a installation date" do
      station = Station.create(name: "Corner Store", dock_count: 22, city_id: 3)

      expect(station).to_not be_valid
    end
  end
  describe "dashboard" do
    it "returns average bikes per stations" do
      city1 = City.create!(name: 'Denver')
      city1.stations.create(name: Faker::Cat.name, dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create!(name: 'Seattle')
      city2.stations.create(name: Faker::Cat.name, dock_count: 11, installation_date: '01/01/2017')

      expect(Station.average_bikes).to eq(10.5)
    end

    it "returns the lowest number of bikes" do
      city1 = City.create!(name: 'Denver')
      city1.stations.create(name: "Portland", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create!(name: 'Seattle')
      city2.stations.create(name: "Tucson", dock_count: 11, installation_date: '01/01/2017')

      expect(Station.fewest_bikes).to eq(10)
      expect(Station.name_fewest_bikes).to eq("Portland")
    end

    it 'returns the highest number of bikes' do
      city1 = City.create!(name: 'Denver')
      city1.stations.create(name: "Pampa", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create!(name: 'Seattle')
      city2.stations.create(name: "Austin", dock_count: 11, installation_date: '01/01/2017')

      expect(Station.most_bikes).to eq(11)
      expect(Station.name_most_bikes).to eq("Austin")
    end

    it 'returns newest station' do
      city1 = City.create!(name: 'Denver')
      city1.stations.create(name: "Faker::Cat.name", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create!(name: 'Seattle')
      city2.stations.create(name: "Dog", dock_count: 11, installation_date: '01/04/2017')

      expect(Station.newest_station).to eq("Dog: 4/1/2017")
    end

    it 'returns oldest station' do
      city1 = City.create!(name: 'Denver')
      city1.stations.create(name: "Cat", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create!(name: 'Seattle')
      city2.stations.create(name: "Dog", dock_count: 11, installation_date: '01/04/2017')

      expect(Station.oldest_station).to eq("Cat: 1/1/2017")
    end

    it 'returns most frequent destination station' do
      city1 = City.create(name: 'Denver')
      station_1 = city1.stations.create(name: "Cat", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create(name: 'Seattle')
      station_2 = city2.stations.create(name: "Dog", dock_count: 11, installation_date: '01/04/2017')
      station_3 = city2.stations.create(name: "Boise", dock_count: 11, installation_date: '01/04/2017')
      subscription = Subscription.create(account: "subscriber")
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_3.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      expect(station_1.most_frequent_destination).to eq(station_2.name)
    end

    it 'returns most frequent origin station' do
      city1 = City.create(name: 'Denver')
      station_1 = city1.stations.create(name: "Cat", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create(name: 'Seattle')
      station_2 = city2.stations.create(name: "Dog", dock_count: 11, installation_date: '01/04/2017')
      station_3 = city2.stations.create(name: "Boise", dock_count: 11, installation_date: '01/04/2017')
      subscription = Subscription.create(account: "subscriber")
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_3.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      expect(station_2.most_frequent_origin).to eq(station_1.name)
    end

    it 'returns number of rides ended at station' do
      city1 = City.create(name: 'Denver')
      station_1 = city1.stations.create(name: "Cat", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create(name: 'Seattle')
      station_2 = city2.stations.create(name: "Dog", dock_count: 11, installation_date: '01/04/2017')
      station_3 = city2.stations.create(name: "Boise", dock_count: 11, installation_date: '01/04/2017')
      subscription = Subscription.create(account: "subscriber")
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_3.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      expect(station_2.rides_ended).to eq(2)
      expect(station_3.rides_ended).to eq(1)
    end

    it 'returns number of rides started at station' do
      city1 = City.create(name: 'Denver')
      station_1 = city1.stations.create(name: "Cat", dock_count: 10, installation_date: '01/01/2017')
      city2 = City.create(name: 'Seattle')
      station_2 = city2.stations.create(name: "Dog", dock_count: 11, installation_date: '01/04/2017')
      station_3 = city2.stations.create(name: "Boise", dock_count: 11, installation_date: '01/04/2017')
      subscription = Subscription.create(account: "subscriber")
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_1.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_2.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      Trip.create(duration: 88,
                  start_station_id: station_2.id,
                  start_date: '01/01/2017 14:14',
                  end_date: '01/01/2017 15:30',
                  end_station_id: station_3.id,
                  subscription_id: subscription.id,
                  bike_id: bike.id,
                  zipcode_id: zipcode.id)

      expect(station_1.rides_started).to eq(2)
      expect(station_2.rides_started).to eq(1)
    end
  end
end
