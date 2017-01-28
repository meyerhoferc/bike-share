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
    stations = Station.all.count
    (1..stations).to_a.each do |id|
      station = Station.find(id)
      visit("/stations/#{id.to_s}")

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end
  end
end
