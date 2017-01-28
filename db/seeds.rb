require './app/models/station.rb'
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

count = 0

stations.each do |row|
  # require 'pry'; binding.pry
  count += 1
  station = Station.new(name: row[:name], dock_count: row[:dock_count].to_i, city: row[:city], installation_date: row[:installation_date])
  puts row[:installation_date]
  puts station.installation_date
  station.save!
  puts "Station: #{station.name} Count: #{count}"
end

# how to grab database object?
# database.execute("COPY stations FROM '/csv/station.csv' DELIMITER ',' CSV;")
