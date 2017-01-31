require_relative '../spec_helper'

describe "user goes to trip dashboard" do
  it "sees the shortest ride time" do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    trip = Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
   trip1 = Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike.id,
                      zipcode_id: zipcode.id)

    visit '/trips-dashboard'

    within('h1') do
      expect(page).to have_content('Trip Dashboard')
    end

    within('.card-content') do
      expect(page).to have_content('Shortest Ride (seconds): 77')
    end
  end

  it 'sees the longest ride time' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    trip = Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
   trip1 = Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike.id,
                      zipcode_id: zipcode.id)

    visit '/trips-dashboard'

    within('.card-content') do
      expect(page).to have_content('Longest Ride (seconds): 88')
    end
  end

  it 'sees the average duration of all rides' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    trip = Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
   trip1 = Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike.id,
                      zipcode_id: zipcode.id)

    visit '/trips-dashboard'

    within('.card-content') do
      expect(page).to have_content('Average Trip Time (seconds): 82.5')
    end
  end
end
