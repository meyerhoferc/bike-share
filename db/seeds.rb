require './app/models/station.rb'
require './app/models/city.rb'
require './app/models/bike.rb'
require './app/models/subscription.rb'
require './app/models/zipcode.rb'
require './app/models/trip.rb'
require 'csv'

stations = CSV.open 'db/csv/station.csv',
headers: true, header_converters: :symbol

trips = CSV.open 'db/csv/trip.csv',
headers: true, header_converters: :symbol

def format_date(date)
  day, month, year = date.split('/')
  [month, day, year].join('/')
end

stations.each do |row|
  city = City.find_or_create_by(name: row[:city])
  city.stations.create!(name: row[:name], dock_count: row[:dock_count].to_i, installation_date: format_date(row[:installation_date]))
end

count = 0
trips.each do |row|
  start_station = row[:start_station_name]
  end_station = row[:end_station_name]

  start_station = "Stanford in Redwood City" if start_station == "Broadway at Main"
  end_station = "Stanford in Redwood City" if end_station == "Broadway at Main"
  start_station = "Santa Clara County Civic Center" if start_station == "San Jose Government Center"
  end_station = "Santa Clara County Civic Center" if end_station == "San Jose Government Center"

  zipcode = Zipcode.find_or_create_by(zip_code: row[:zip_code]).id
  bike = Bike.find_or_create_by!(bike_number: row[:bike_id]).id
  subscription = Subscription.find_or_create_by!(account: row[:subscription_type]).id
  
  require 'pry'; binding.pry if Station.find_by(name: start_station).id.nil?
  require 'pry'; binding.pry if Station.find_by(name: end_station).id.nil?

  start_station = Station.find_by(name: start_station).id
  end_station = Station.find_by(name: end_station).id
  duration = row[:duration]
  start_date = format_date(row[:start_date])
  end_date = format_date(row[:end_date])

  Trip.create!(duration: duration,
              start_date: start_date,
              start_station_id: start_station,
              end_date: end_date,
              end_station_id: end_station,
              bike_id: bike,
              subscription_id: subscription,
              zipcode_id: zipcode)
  count += 1
  if count > 670000
    exit
  end
  # puts count/
end

# replace "Broadway at Main" with "Stanford in Redwood City" (station 25)
# replace "San Jose Government Center" with "Santa Clara County Civic Center" (station 80)
