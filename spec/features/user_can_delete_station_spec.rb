require_relative '../spec_helper'
require 'faker'

describe 'user deletes station' do
  it 'can be deleted from show page' do
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: Faker::Cat.name, dock_count: Faker::Number.number(1), installation_date: '01/01/2017')

    visit('/stations/1')
    click_on('Delete')

    expect(page).to have_current_path('/stations')
    expect(Station.all.count).to eq(0)
  end

  # needs delete test for index page
end
