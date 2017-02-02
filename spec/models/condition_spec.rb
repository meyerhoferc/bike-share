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
end
