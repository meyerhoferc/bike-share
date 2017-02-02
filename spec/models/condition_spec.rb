require_relative '../spec_helper'

describe Condition do
  describe "validations" do
    it "is invalid without date" do
      weather = Condition.create(max_temperature_f: "90",
                                 mean_temperature_f: "75",
                                 min_temperature_f: "19",
                                 mean_humidity: "0.50",
                                 mean_visibility: "1",
                                 mean_wind_speed: "10",
                                 precipitation_inches: "4")

      expect(weather).to_not be_valid
    end
  end

  describe ".temp_highest_rides" do
    it "returns the highest number of rides for a temp range" do
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

  expect(Condition.temp_highest_rides.last).to eq("Temp: 90...100 had 1 rides")
    end
  end

  describe ".precipitation_highest_rides" do
    it "returns the highest number of rides for a precipitation range" do
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
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "0.3")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "0.7")
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

  expect(Condition.precipitation_highest_rides.last).to eq("Precipitation: 0.5...1.0 had 1 rides")
    end
  end
  describe ".precipitation_lowest_rides" do
    it "returns the lowest number of rides for a precipitation range" do
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
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "0.3")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "0.7")
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
                 start_date: '29/07/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_2.id)
    Trip.create!(duration: 102,
                 start_date: '29/07/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_2.id)

    expect(Condition.precipitation_lowest_rides.last).to eq("Precipitation: 0.5...1.0 had 2 rides")
    end
  end

  describe ".precipitation_average_rides" do
    it "returns the average number of rides for a precipitation range" do
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
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "0.3")
    condition_2 = Condition.create(date: "29/07/2013",
                    max_temperature_f: "90",
                    mean_temperature_f: "75",
                    min_temperature_f: "19",
                    mean_humidity: "0.50",
                    mean_visibility: "1",
                    mean_wind_speed: "10",
                    precipitation_inches: "0.7")
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
                 start_date: '29/07/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_2.id)
    Trip.create!(duration: 102,
                 start_date: '29/07/2013 14:13',
                 start_station_id: station_1.id,
                 end_date: '01/01/2017 15:30',
                 end_station_id: station_2.id,
                 bike_id: bike.id,
                 subscription_id: subscription.id,
                 zipcode_id: zipcode.id,
                 condition_id: condition_2.id)

    expect(Condition.precipitation_average_rides.last).to eq("Precipitation: 0.5...1.0 Averaged: 2.0 rides")
    end
  end

  describe '.visibility_highest_rides' do
    it 'returns the highest trips count for days with visibility in a range' do
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

    expect(Condition.visibility_highest_rides.first).to eq("Visibility: 0...4 miles had 1 trips")
    expect(Condition.visibility_highest_rides.last).to eq("Visibility: 4...8 miles had 2 trips")
    end
  end

  describe '.visibility_lowest_rides' do
    it 'returns the lowest trips count for days with visibility in a range' do
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

    expect(Condition.visibility_lowest_rides.first).to eq("Visibility: 0...4 miles had 1 trips")
    expect(Condition.visibility_lowest_rides.last).to eq("Visibility: 4...8 miles had 1 trips")
    end
  end

  describe '.visibility_average_rides' do
    it 'returns the average trip count for days with visibility in a range' do
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

    expect(Condition.visibility_average_rides.first).to eq("Visibility: 0...4 miles had an average of 1 trips")
    expect(Condition.visibility_average_rides.last).to eq("Visibility: 4...8 miles had an average of 1 trips")
    end
  end

  describe '.wind_maximum_rides' do
    it 'returns the maximum trip count for days with wind speed in a range' do
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

    expect(Condition.wind_maximum_rides.first).to eq("Wind Speed: 8...12 miles per hour had a maximum of 2 trips")
    expect(Condition.wind_maximum_rides.last).to eq("Wind Speed: 20...24 miles per hour had a maximum of 1 trips")
    end
  end

  describe '.wind_minimum_rides' do
    it 'returns the minimum trip count for days with wind speed in a range' do
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

    expect(Condition.wind_minimum_rides.first).to eq("Wind Speed: 8...12 miles per hour had a minimum of 1 trips")
    expect(Condition.wind_minimum_rides.last).to eq("Wind Speed: 20...24 miles per hour had a minimum of 1 trips")
    end
  end

  describe '.wind_average_rides' do
    it 'returns the average trip count for days with wind speed in a range' do
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

      expect(Condition.wind_average_rides.first).to eq("Wind Speed: 8...12 miles per hour had an average of 1 trips")
      expect(Condition.wind_average_rides.last).to eq("Wind Speed: 20...24 miles per hour had an average of 1 trips")
    end
  end

  describe ".temp_highest_rides" do
    it "returns the highest number of rides for a temp range" do
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

      expect(Condition.temp_average_rides.first).to eq("Temp: 70...80 averaged 1.5 rides")
    end
  end
end
