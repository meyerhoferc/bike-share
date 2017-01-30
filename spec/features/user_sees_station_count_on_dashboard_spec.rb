require_relative '../spec_helper'

describe "When user visits /dashboard" do
  it 'they see total station count' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')
    city2 = City.create!(name: 'Chicago')
    city2.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/14/2017')

    Station.all.each do |station|
      visit('/')
      city = City.find(station.city_id)

      expect(page).to have_content("10")
end
end
