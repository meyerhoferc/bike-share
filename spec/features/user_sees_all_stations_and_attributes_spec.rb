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
    5.times { Station.create(station_params) }

    Station.all.each do |station|
      visit('/stations')

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end
  end

  it 'can redirect to edit from stations/index' do
    Station.create(station_params)
    visit('/stations')
    click_on('Edit')

    expect(page).to have_current_path('/stations/1/edit')
  end

end
