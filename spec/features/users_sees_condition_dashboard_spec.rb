require_relative '../spec_helper'

describe 'user goes to conditions dashboard' do
  it 'has dashboard values' do
    subscription = Subscription.create(account: "subscriber")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    condition_1 = Condition.create(date: "29/08/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "4")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "1",
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
                       condition: condition_1)
    Trip.create!(duration: 102,
                       start_date: '29/08/2013 14:13',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id,
                       condition: condition_2)
    Trip.create!(duration: 102,
                       start_date: '29/07/2013 14:13',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id,
                       condition: condition_1)

    visit('/weather-dashboard')

    expect(find('.weather')).to have_content("Temp: 90...100 had 2 rides")
    expect(find('.weather')).to have_content("Temp: 90...100 had 1 rides")
    expect(find('.weather')).to have_content("Temp: 90...100 averaged 1.5")
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


  it 'sees the average number of rides for mean visibility' do
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

    within('.average-visibility-data') do
      expect(page).to have_content("Visibility: 0...4 miles had an average of 1 trips")
      expect(page).to have_content("Visibility: 4...8 miles had an average of 1 trips")
    end
  end

  it 'sees the maximum trip count for days with wind speed in a range' do
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
                    mean_wind_speed: "22",
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
    visit '/weather-dashboard'

    within('.wind-maximum-rides') do
      expect(page).to have_content("Wind Speed: 8...12 miles per hour had a maximum of 2 trips")
      expect(page).to have_content("Wind Speed: 20...24 miles per hour had a maximum of 1 trips")
    end
  end

  it 'sees the minimum trip count for days with wind speed in a range' do
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
                    mean_wind_speed: "22",
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
    visit '/weather-dashboard'

    within('.wind-minimum-rides') do
      expect(page).to have_content("Wind Speed: 8...12 miles per hour had a minimum of 1 trips")
      expect(page).to have_content("Wind Speed: 20...24 miles per hour had a minimum of 1 trips")
    end
  end

  it 'sees the average trip count for days with wind speed in a range' do
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
                    mean_wind_speed: "22",
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
    visit '/weather-dashboard'

    within('.wind-average-rides') do
      expect(page).to have_content("Wind Speed: 8...12 miles per hour had an average of 1 trips")
      expect(page).to have_content("Wind Speed: 20...24 miles per hour had an average of 1 trips")
    end
  end

  it 'sees the maximum trip count for days with precipitation in a range' do
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
                    precipitation_inches: ".5")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "3",
                    mean_wind_speed: "22",
                    precipitation_inches: ".5")
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
    visit '/weather-dashboard'

    # require 'pry'; binding.pry

    within('.prec-max-rides') do
      expect(page).to have_content("Precipitation: 0.5...1.0 had 2 rides")
    end
  end

  it 'sees the minimum trip count for days with precipitation in a range' do
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
                    precipitation_inches: "0.5")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "3",
                    mean_wind_speed: "22",
                    precipitation_inches: "0.5")
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
    visit '/weather-dashboard'

    within('.prec-min-rides') do
      expect(page).to have_content("Precipitation: 0.5...1.0 had 1 rides")
    end
  end

  it 'sees the average precipitation for days with precipitation in a range' do
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
                    precipitation_inches: "0.5")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "3",
                    mean_wind_speed: "22",
                    precipitation_inches: "0.5")
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
    visit '/weather-dashboard'
    
    within('.prec-average-rides') do
      expect(page).to have_content("Precipitation: 0.5...1.0 Averaged: 1.33 rides")
    end
  end
end
