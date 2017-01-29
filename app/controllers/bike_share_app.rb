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

 get '/trips/:id' do
   @trip = Trip.find(params[:id])
   erb :"trip/show"
 end

end
