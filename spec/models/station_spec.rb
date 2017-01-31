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
  end
end
