require_relative '../spec_helper'
require 'pry'

def station_params
  {
    name: Faker::Cat.name,
    dock_count: Faker::Number.number(1),
    city: Faker::Space.galaxy,
    installation_date: '01/02/2017'
  }
end

describe "When user visits stations/index" do
  it "they see all stations" do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')
    city2 = City.create!(name: 'Chicago')
    city2.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/14/2017')

    Station.all.each do |station|
      visit('/stations')
      city = City.find(station.city_id)

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(city.name)
      expect(page).to have_content(station.installation_date)
    end
  end

  it 'can redirect to edit from stations/index' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')
    visit('/stations')
    click_on('Edit')

    expect(page).to have_current_path('/stations/1/edit')
  end

end
