require_relative '../spec_helper'

describe "user goes to station dashboard" do
  it 'sees total count of stations' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: 10, installation_date: '01/01/2017')
    city2 = City.create!(name: 'Seattle')
    city2.stations.create(name: Faker::Cat.name, dock_count: 11, installation_date: '01/01/2017')

    visit '/station-dashboard'
    within("#station-dashboard-info") do
      expect(page).to have_content("Total Stations")
      expect(page).to have_content(2)
      expect(Station.count).to eq(2)
    end
  end

  it 'sees average number of bikes' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: 10, installation_date: '01/01/2017')
    city2 = City.create!(name: 'Seattle')
    city2.stations.create(name: Faker::Cat.name, dock_count: 11, installation_date: '01/01/2017')

    visit '/station-dashboard'

    within("#station-dashboard-bikes") do
      expect(page).to have_content('10.5')
    end
  end

  it 'sees fewest bikes' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: "Tallahassee", dock_count: 10, installation_date: '01/05/2017')
    city2 = City.create!(name: 'Seattle')
    city2.stations.create(name: "Tucson", dock_count: 11, installation_date: '01/01/2017')
    city2.stations.create(name: "Fargo", dock_count: 10, installation_date: '01/02/2017')

    visit '/station-dashboard'
    within("#station-dashboard-bikes") do
      expect(page).to have_content("10")
      expect(page).to have_content("Fewest Bikes")
      expect(page).to have_content("Station with Fewest Bikes: Tallahassee")
    end
  end

  it 'sees most bikes' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: "Pampa", dock_count: 10, installation_date: '01/01/2017')
    city2 = City.create!(name: 'Seattle')
    city2.stations.create(name: "Austin", dock_count: 11, installation_date: '01/01/2017')

    visit '/station-dashboard'
    within("#station-dashboard-bikes") do
      expect(page).to have_content("11")
      expect(page).to have_content("Most Bikes")
      expect(page).to have_content("Station with Most Bikes: Austin")
    end
  end

  it 'sees newest station' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: 10, installation_date: '01/01/2017')
    city2 = City.create!(name: 'Seattle')
    city2.stations.create(name: "Tucson", dock_count: 11, installation_date: '01/04/2017')

    visit '/station-dashboard'
    within("#station-dashboard-info") do
      expect(page).to have_content("Newest Station")
      expect(page).to have_content("Tucson: 4/1/2017")
    end
  end

  it 'sees oldest station' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: "Portland", dock_count: 10, installation_date: '01/01/2017')
    city2 = City.create!(name: 'Seattle')
    city2.stations.create(name: "Tucson", dock_count: 11, installation_date: '01/04/2017')

    visit '/station-dashboard'
    within("#station-dashboard-info") do
      expect(page).to have_content("Oldest Station")
      expect(page).to have_content("Portland: 1/1/2017")
    end
  end
end
