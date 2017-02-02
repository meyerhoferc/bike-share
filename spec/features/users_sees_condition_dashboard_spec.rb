require_relative '../spec_helper'

describe 'user goes to conditions dashboard' do
  it 'sees the highest number of rides' do
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
    trip = Trip.create!(duration: 102,
                       start_date: '29/08/2013 14:13',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id)
    trip = Trip.create!(duration: 102,
                       start_date: '29/07/2013 14:13',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id)
    Condition.create(date: "29/08/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "4")
    Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "4")
    visit('/weather-dashboard')

    expect('#temp-highest-rides').to have_content("Temp: 90 - 100 had 2 rides")
  end

  it 'sees the highest number of rides for mean visibility' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    condition_1 = Condition.create(date: "29/08/2013",
                    max_temperature_f: "70",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "4",
                    mean_wind_speed: "10",
                    precipitation_inches: "4")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "3",
                    mean_wind_speed: "10",
                    precipitation_inches: "4")
    Trip.create!(duration: 102,
                 start_date: '29/08/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_1.id)
   Trip.create!(duration: 102,
                start_date: '31/08/2013 14:13',
                start_station_id: station_1.id,
                end_date: '01/01/2017 15:30',
                end_station_id: station_2.id,
                bike_id: bike.id,
                subscription_id: subscription.id,
                zipcode_id: zipcode.id,
                condition_id: condition_1.id)
    Trip.create!(duration: 102,
                 start_date: '29/08/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_1.id)
    Trip.create!(duration: 102,
                 start_date: '29/07/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_2.id)

    visit('/weather-dashboard')

    within('.maximum-visibility-data') do
      expect(page).to have_content("Visibility: 0...4 miles had 1 trips")
      expect(page).to have_content("Visibility: 4...8 miles had 2 trips")
    end
  end

  it 'sees the lowest number of rides for mean visibility' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    condition_1 = Condition.create(date: "29/08/2013",
                    max_temperature_f: "70",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "4",
                    mean_wind_speed: "10",
                    precipitation_inches: "4")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "3",
                    mean_wind_speed: "10",
                    precipitation_inches: "4")
    Trip.create!(duration: 102,
                 start_date: '29/08/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_1.id)
   Trip.create!(duration: 102,
                start_date: '31/08/2013 14:13',
                start_station_id: station_1.id,
                end_date: '01/01/2017 15:30',
                end_station_id: station_2.id,
                bike_id: bike.id,
                subscription_id: subscription.id,
                zipcode_id: zipcode.id,
                condition_id: condition_1.id)
    Trip.create!(duration: 102,
                 start_date: '29/08/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_1.id)
    Trip.create!(duration: 102,
                 start_date: '29/07/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_2.id)

    visit('/weather-dashboard')

    within('.minimum-visibility-data') do
      expect(page).to have_content("Visibility: 0...4 miles had 1 trips")
      expect(page).to have_content("Visibility: 4...8 miles had 1 trips")
    end
  end
end
