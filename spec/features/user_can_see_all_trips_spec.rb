require_relative '../spec_helper'

describe 'user goes to index' do
  it 'they see all trips' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    trip = Trip.create!(duration: 102,
                       start_date: '29/08/2013 14:13',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id)

    visit('/trips')

    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(station_1.name)
    expect(page).to have_content(trip.end_date)
    expect(page).to have_content(station_2.name)
    expect(page).to have_content(bike.bike_number)
    expect(page).to have_content(subscription.account)
    expect(page).to have_content(zipcode.zip_code)
  end
end
