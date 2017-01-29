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

describe 'user deletes station' do
  it 'can be deleted from show page' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')

    visit('/stations/1')
    click_on('Delete')

    expect(page).to have_current_path('/stations')
    expect(Station.all.count).to eq(0)
  end

  it 'can be deleted from index page' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')
    visit('/stations')
    click_on('Delete')

    expect(page).to have_current_path('/stations')
    expect(Station.all.count).to eq(0)
  end
end
