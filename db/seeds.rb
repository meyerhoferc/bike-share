require './app/models/station.rb'
require 'faker'

dates = ['01/01/2017', '01/02/2017', '01/03/2017', '01/04/2017', '01/05/2017']

dates.each do |date|
  Station.create(name: Faker::Cat.name, dock_count: Faker::Number.number(2),
  city: Faker::Space.galaxy, installation_date: date)
end
