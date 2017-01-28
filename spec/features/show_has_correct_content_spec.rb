require_relative '../spec_helper'
require 'faker'

describe 'user goes to show page' do
  it 'sees page title' do
    Station.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1),
    city: Faker::Space.galaxy, installation_date: '01/01/2017')
    Station.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1),
    city: Faker::Space.galaxy, installation_date: '01/02/2017')

    visit('/stations/1')

    within('h1') {expect(page).to have_content('Station Information')}
  end

  it 'sees station information' do
    Station.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1),
    city: Faker::Space.galaxy, installation_date: '01/01/2017')
    Station.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1),
    city: Faker::Space.galaxy, installation_date: '01/02/2017')

    Station.all.each do |station|
      visit("/stations/#{station.id}")

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end
  end
end
