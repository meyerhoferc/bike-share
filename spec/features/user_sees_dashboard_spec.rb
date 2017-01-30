require_relative '../spec_helper'

describe "user goes to station dashboard" do
  it 'sees total count of stations' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: 10, installation_date: '01/01/2017')
    city2 = City.create!(name: 'Seattle')
    city2.stations.create(name: Faker::Cat.name, dock_count: 11, installation_date: '01/01/2017')

    visit '/station-dashboard'

    expect(page).to have_content("Total Stations")
    expect(page).to have_content(2)
    expect(Station.count).to eq(2)
  end
end
