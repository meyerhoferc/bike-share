require_relative '../spec_helper'

describe 'user goes to index' do
  it 'they see all trips' do
    #needs some data
    visit('/trips')

    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(start_station.name)
    expect(page).to have_content(trip.end_date)
    expect(page).to have_content(end_station.name)
    expect(page).to have_content(bike.bike_number)
    expect(page).to have_content(subscription.type)
    expect(page).to have_content(zipcode.zip_code)
  end
end
