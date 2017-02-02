require_relative '../spec_helper'
require 'faker'

def station_params
  {
    name: Faker::Cat.name,
    dock_count: Faker::Number.number(1),
    city: Faker::Space.galaxy,
    installation_date: '01/02/2017'
  }
end

describe 'user goes to show page' do
  let(:city1) { City.create!(name: 'Denver') }
  let(:city2) { City.create!(name: 'Tucson') }

  let(:station_1) do
    city1.stations.create(name: "Market and 8th", dock_count: Faker::Number.number(1), installation_date: '01/01/2017')
  end

  let(:station_2) do
    city2.stations.create(name: "7th and Speer", dock_count: Faker::Number.number(1), installation_date: '01/02/2017')
  end

  let(:station_3) do
    city1.stations.create(name: "Shenanigans", dock_count: 54, installation_date: "01/03/2017")
  end

  let(:subscription) do
    Subscription.create(account: "subscriber")
  end

  let(:zipcode) do
    Zipcode.create(zip_code: 85701)
  end

  let(:bike) do
    Bike.create(bike_number: 28)
  end

  it 'sees page title' do
    station_1
    visit('/stations/1')

    within('h1') {expect(page).to have_content('Station Information')}
  end

  it 'sees station information' do
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
    Station.all.each do |station|
      visit("/stations/#{station.id}")
      city = City.find(station.city_id)

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(city.name)
      expect(page).to have_content(station.installation_date)
      expect(page).to have_content(station.most_frequent_destination)
      expect(page).to have_content(station.most_frequent_origin)
      expect(find("#rides_ending")).to have_content(station.rides_ended)
      expect(find("#day_with_most_starts")).to have_content(station.day_with_most_starts)
      expect(find('#rides_starting')).to have_content(station.rides_started)
      expect(find('#most_frequent_zipcode')).to have_content(station.most_frequent_zipcode)
      expect(find('#most_frequent_bike')).to have_content(station.most_frequent_bike)
    end
  end
end
