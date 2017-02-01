require './app/models/station.rb'
require './app/models/city.rb'
require './app/models/bike.rb'
require './app/models/subscription.rb'
require './app/models/zipcode.rb'
require './app/models/trip.rb'
require './app/models/condition.rb'
require 'csv'

stations = CSV.open 'db/csv/station.csv',
headers: true, header_converters: :symbol

trips = CSV.open 'db/csv/trip.csv',
headers: true, header_converters: :symbol

conditions = CSV.open 'db/csv/weather.csv',
headers:true, header_converters: :symbol

def format_date(date)
  day, month, year = date.split('/')
  [month, day, year].join('/')
end

stations_cache = {}

stations.each do |row|
  city = City.find_or_create_by!(name: row[:city])
  station = city.stations.create!(id: row[:id], name: row[:name], dock_count: row[:dock_count].to_i, installation_date: format_date(row[:installation_date]))
  stations_cache[station.id] = station
end

zipcode_cache = {}
bike_cache = {}
subscription_cache = {}

trips.each do |row|
  begin
    start_station = row[:start_station_id].to_i
    end_station = row[:end_station_id].to_i

    if zipcode_cache[(row[:zip_code])]
      zipcode = zipcode_cache[(row[:zip_code])]
    else
      zipcode = Zipcode.create(zip_code: (row[:zip_code]))
      zipcode_cache[(row[:zip_code])] = zipcode
    end

    if bike_cache[(row[:bike_id])]
      bike = bike_cache[(row[:bike_id])]
    else
      bike = Bike.create(bike_number: row[:bike_id])
      bike_cache[(row[:bike_id])] = bike
    end

    if subscription_cache[row[:subscription_type]]
      subscription = subscription_cache[row[:subscription_type]]
    else
      subscription = Subscription.create(account: row[:subscription_type])
      subscription_cache[row[:subscription_type]] = subscription
    end

    start_station = stations_cache[start_station]
    end_station = stations_cache[end_station]
    duration = row[:duration]
    start_date = format_date(row[:start_date])
    end_date = format_date(row[:end_date])

    Trip.create!(duration: duration,
    start_date: start_date,
    start_station: start_station,
    end_date: end_date,
    end_station: end_station,
    bike: bike,
    subscription: subscription,
    zipcode: zipcode)

  rescue => e
    puts e
    puts row
  end

  conditions.each do |row|
    begin

  Condition.create!(
                    date: format_date(row[:date]),
                    max_temperature_f: row[:max_temperature_f],
                    mean_temperature_f: row[:mean_temperature_f],
                    min_temperature_f: row[:min_temperature_f],
                    mean_humidity: row[:mean_humidity],
                    mean_visibility: row[:mean_visibility_miles],
                    mean_wind_speed: row[:mean_wind_speed_mph],
                    precipitation_inches: row[:precipitation_inches]
                   )
   rescue => e
     puts e
     puts row
   end
  end
end
