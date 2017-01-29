class BikeShareApp < Sinatra::Base
 get '/' do
   "Hello"
 end

 get '/stations' do
   @stations = Station.all

   erb :"station/index"
 end

 get '/stations/new' do
   erb :'station/new'
 end

 get '/stations/:id' do
   @station = Station.find(params[:id])
   erb :'station/show'
 end

 post '/stations' do
   city_name = params[:station][:city]
   @city = City.create(name: city_name)
   input = {
     name: params[:station][:name],
     dock_count: params[:station][:dock_count],
     city_id: @city_id,
     installation_date: params[:station][:installation_date]
   }
   @station = @city.stations.create(input)

   redirect "/stations/#{@station.id}"
 end

 get '/stations/:id/edit' do
   @station = Station.find(params[:id])

   erb :'station/edit'
 end

 put '/stations/:id' do
   city = params[:station][:city]
   @city_id = City.find_by(name: city).id
   input = {
     name: params[:station][:name],
     dock_count: params[:station][:dock_count],
     city_id: @city_id,
     installation_date: params[:station][:installation_date]
   }
   @station = Station.update(params[:id], input)
   station_id = @station.id

   redirect "/stations/#{station_id}"
 end

 delete '/stations/:id' do
   @station = Station.destroy(params[:id])

   redirect '/stations'
 end

 # ===================================== BEGIN TRIPS ======================================

 get '/trips' do
   @trips = Trip.all
   erb :"trip/index"
 end

 get '/trips/new' do
   erb :"trip/new"
 end

 post '/trips' do
   bike = Bike.create(bike_number: params[:trip][:bike])
   subscription = Subscription.create(account: params[:trip][:subscription])
   zipcode = Zipcode.create(zip_code: params[:trip][:zipcode])
   start_station = Station.find_by(name: params[:trip][:start_station])
   end_station = Station.find_by(name: params[:trip][:end_station])
   start_date = params[:trip][:start_date]
   end_date = params[:trip][:end_date]
   duration = params[:trip][:duration]
   input = {
     bike_id: bike.id,
     subscription_id: subscription.id,
     zipcode_id: zipcode.id,
     start_station_id: start_station.id,
     end_station_id: end_station.id,
     start_date: start_date,
     end_date: end_date,
     duration: duration
   }
   trip = Trip.create(input)

   redirect "/trips/#{trip.id}"
 end

 get '/trips/:id' do
   @trip = Trip.find(params[:id])
   erb :"trip/show"
 end

 get '/trips/:id/edit' do
   @trip = Trip.find(params[:id])
   erb :"trip/edit"
 end

 put '/trips/:id' do
   start_station = params[:trip][:start_station]
   start_station_id = Station.find_by(name: start_station).id
   end_station =  params[:trip][:end_station]
   end_station_id = Station.find_by(name: end_station).id
   zipcode = params[:trip][:zipcode]
   zipcode_id = Zipcode.find_by(zip_code: zipcode).id
   subscription = params[:trip][:subscription]
   subscription_id = Subscription.find_by(account: subscription).id
   bike = params[:trip][:bike]
   bike_id = Bike.find_by(bike_number: bike).id

   input = {
     start_station_id: start_station_id,
     end_station_id: end_station_id,
     zipcode_id: zipcode_id,
     subscription_id: subscription_id,
     bike_id: bike_id,
     duration: params[:trip][:duration],
     start_date: params[:trip][:start_date],
     end_date: params[:trip][:end_date]
   }

   @trip = Trip.update(params[:id], input)
   redirect "/trips/#{@trip.id}"
 end

end
