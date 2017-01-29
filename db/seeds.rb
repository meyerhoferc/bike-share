require './app/models/station.rb'
require './app/models/city.rb'
require 'faker'
require 'csv'

# dates = ['01/01/2017', '01/02/2017', '01/03/2017', '01/04/2017', '01/05/2017']
#
# dates.each do |date|
#   Station.create(name: Faker::Cat.name, dock_count: Faker::Number.number(2),
#   city: Faker::Space.galaxy, installation_date: date)
# end

stations = CSV.open 'db/csv/station.csv',
headers: true, header_converters: :symbol

def format_date(date)
  day, month, year = date.split('/')
  [month, day, year].join('/')
end

stations.each do |row|
  city = City.find_or_create_by(name: row[:city])
  city.stations.create!(name: row[:name], dock_count: row[:dock_count].to_i, installation_date: format_date(row[:installation_date]))
end
#look up all entities, store, and then set in Trip
#we can use station_name from csv to look up the station
#Trip.create(start_station: station, end_station: station, bike: bike, subcription: subscription, zipcode: zipcode)
