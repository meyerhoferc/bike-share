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

describe 'user edits station' do
  it 'redirects to /new for a form' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')

    visit('/stations/1')
    click_on('Edit')

    expect(page).to have_current_path('/stations/1/edit')
  end

  it 'updates an existing record' do
    city1 = City.create!(name: 'Denver')
    city2 = City.create!(name: 'Seattle')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')

    visit('/stations/1/edit')
    fill_in('station[name]', :with => "New Name")
    fill_in('station[city]', :with => "Seattle")
    fill_in('station[dock_count]', :with => "38")
    fill_in('station[installation_date]', :with => "07/07/2016")
    click_on('Submit')

    expect(page).to have_current_path('/stations/1')
    expect(page).to have_content('New Name')
    expect(page).to have_content('Seattle')
    expect(page).to have_content('38')
    expect(page).to have_content('2016-07-07')
  end
end
