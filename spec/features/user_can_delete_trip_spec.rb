require_relative '../spec_helper'

describe 'user deletes trip' do
  it 'from index' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create(duration: 102,
                       start_date: '01/01/2017 14:14',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id)
    visit '/trips'
    click_on('Delete')

    expect(Trip.count).to eq(0)
    expect(current_path).to eq('/trips')
  end

  it 'from show' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    trip = Trip.create(duration: 102,
                       start_date: '01/01/2017 14:14',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id)
    visit "/trips/#{trip.id}"
    click_on('Delete')

    expect(Trip.count).to eq(0)
    expect(current_path).to eq('/trips')
  end
end
