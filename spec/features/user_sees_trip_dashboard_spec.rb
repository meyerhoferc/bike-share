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
    Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
   Trip.create!(duration: 77,
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
    Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
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
    Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
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

  it 'sees the day with the most amount of rides' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike.id,
                      zipcode_id: zipcode.id)

    visit '/trips-dashboard'
    within('.card-content') do
      expect(page).to have_content('Busiest Day: 1/1/2017 had 2 rides')
    end
  end

  it 'sees the day with the fewest amount of rides' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike.id,
                      zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                     start_station_id: station_1.id,
                     start_date: '01/04/2017 14:14',
                     end_date: '01/03/2017 15:30',
                     end_station_id: station_2.id,
                     subscription_id: subscription.id,
                     bike_id: bike.id,
                     zipcode_id: zipcode.id)

    visit '/trips-dashboard'
    within('.card-content') do
      expect(page).to have_content('Slowest Day: 4/1/2017 had 1 ride')
    end
  end

  it 'sees the bike with the most rides' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike.id,
                      zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                     start_station_id: station_1.id,
                     start_date: '01/04/2017 14:14',
                     end_date: '01/03/2017 15:30',
                     end_station_id: station_2.id,
                     subscription_id: subscription.id,
                     bike_id: bike.id,
                     zipcode_id: zipcode.id)

    visit '/trips-dashboard'

    within('.card-content') do
      expect(page).to have_content('Most Ridden Bike: Bike 28 had 3 rides')
    end
  end

  it 'sees the bike with the fewest number of rides' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    bike2 = Bike.create(bike_number: 38)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create!(duration: 88,
                       start_station_id: station_1.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike.id,
                      zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                     start_station_id: station_1.id,
                     start_date: '01/04/2017 14:14',
                     end_date: '01/03/2017 15:30',
                     end_station_id: station_2.id,
                     subscription_id: subscription.id,
                     bike_id: bike2.id,
                     zipcode_id: zipcode.id)

    visit '/trips-dashboard'

    within('.card-content') do
      expect(page).to have_content('Least Ridden Bike: Bike 38 had 1 ride')
    end
  end

  it 'sees the most common ending station' do
    subscription = Subscription.create(account: "subscriber")
    subscription2 = Subscription.create(account: "customer")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    bike2 = Bike.create(bike_number: 38)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create!(duration: 88,
                       start_station_id: station_2.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_1.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike2.id,
                      zipcode_id: zipcode.id)
   Trip.create!(duration: 77,
                     start_station_id: station_1.id,
                     start_date: '01/04/2017 14:14',
                     end_date: '01/03/2017 15:30',
                     end_station_id: station_2.id,
                     subscription_id: subscription2.id,
                     bike_id: bike2.id,
                     zipcode_id: zipcode.id)
    visit '/trips-dashboard'
    within('.card-content') do
      expect(page).to have_content('Most Common Ending Station: Aquarium')
    end
  end

  it 'sees the most common starting station' do
    subscription = Subscription.create(account: "subscriber")
    subscription2 = Subscription.create(account: "customer")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    bike2 = Bike.create(bike_number: 38)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create!(duration: 88,
                       start_station_id: station_2.id,
                       start_date: '01/01/2017 14:14',
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_1.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/01/2017 14:14',
                      end_date: '01/03/2017 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike2.id,
                      zipcode_id: zipcode.id)
   Trip.create!(duration: 77,
                     start_station_id: station_1.id,
                     start_date: '01/04/2017 14:14',
                     end_date: '01/03/2017 15:30',
                     end_station_id: station_2.id,
                     subscription_id: subscription2.id,
                     bike_id: bike2.id,
                     zipcode_id: zipcode.id)
    visit '/trips-dashboard'
    within('.card-content') do
      expect(page).to have_content('Most Common Starting Station: Golden Gate')
    end
  end

  it 'sees month by month breakdown of trip data' do
    subscription = Subscription.create(account: "subscriber")
    subscription2 = Subscription.create(account: "customer")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    bike2 = Bike.create(bike_number: 38)
    zipcode = Zipcode.create(zip_code: 85701)
    Trip.create!(duration: 88,
                       start_station_id: station_2.id,
                       start_date: '01/01/2013 14:14',
                       end_date: '01/01/2013 15:30',
                       end_station_id: station_1.id,
                       subscription_id: subscription.id,
                       bike_id: bike.id,
                       zipcode_id: zipcode.id)
    Trip.create!(duration: 77,
                      start_station_id: station_1.id,
                      start_date: '01/02/2013 14:14',
                      end_date: '01/03/2013 15:30',
                      end_station_id: station_2.id,
                      subscription_id: subscription.id,
                      bike_id: bike2.id,
                      zipcode_id: zipcode.id)
   Trip.create!(duration: 77,
                     start_station_id: station_1.id,
                     start_date: '01/03/2013 14:14',
                     end_date: '01/03/2013 15:30',
                     end_station_id: station_2.id,
                     subscription_id: subscription2.id,
                     bike_id: bike2.id,
                     zipcode_id: zipcode.id)
   Trip.create!(duration: 77,
                     start_station_id: station_1.id,
                     start_date: '01/03/2013 14:14',
                     end_date: '01/03/2013 15:30',
                     end_station_id: station_2.id,
                     subscription_id: subscription2.id,
                     bike_id: bike2.id,
                     zipcode_id: zipcode.id)

    result = ["1/2013 had 1 rides, total: 1",
    "2/2013 had 1 rides, total: 2",
    "3/2013 had 2 rides, total: 4"]
    visit '/trips-dashboard'
    save_and_open_page
    result.each { |phrase| expect(page).to have_content(phrase) }
  end
end
