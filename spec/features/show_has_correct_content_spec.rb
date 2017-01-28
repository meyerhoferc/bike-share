require_relative '../spec_helper'
require_relative 'load_database'

include LoadDatabase

describe 'user goes to show page' do
  it 'sees page title' do
    LoadDatabase.load
    visit('/stations/1')

    within('h1') {expect(page).to have_content('Station Information')}
  end

  it 'sees station information' do
    LoadDatabase.load
    Station.all.each do |station|
      visit("/stations/#{station.id}")

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end
  end
end
