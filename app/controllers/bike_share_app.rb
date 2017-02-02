# require 'will_paginate'
require 'will_paginate/active_record'
class BikeShareApp < Sinatra::Base
  include WillPaginate::Sinatra::Helpers
 get '/' do
   erb :"home/home"
 end

 get '/stations' do
   @stations = Station.all.paginate(page: params[:page], per_page: 5)

   erb :"station/index"
 end

 get '/stations/new' do
    @stations = Station.all
    @cities = City.all
   erb :'station/new'
 end

 get '/station-dashboard' do
   erb :'station/dashboard'
 end

 get '/stations/:id' do
   @station = Station.find(params[:id])
   erb :'station/show'
 end

 post '/stations' do
   city_name = params[:station][:city]
   city = City.find_or_create_by(name: city_name)
   input = {
     name: params[:station][:name],
     dock_count: params[:station][:dock_count],
     city: city,
     installation_date: params[:station][:installation_date]
   }
   @station = city.stations.create(input)

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
   Station.destroy(params[:id])

   redirect '/stations'
 end

 # ===================================== BEGIN TRIPS ======================================

 get '/trips' do
   @trips = Trip.all.paginate(page: params[:page], per_page: 5)

   erb :"trip/index"
 end

 get '/trips/new' do
   erb :"trip/new"
 end

 get '/trips-dashboard' do
   erb :"trip/dashboard"
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

  delete '/trips/:id' do
   Trip.destroy(params[:id])

   redirect '/trips'
  end
#============Conditions==================================
  get '/conditions' do
    @conditions = Condition.all
    erb :"condition/index"
  end

  get '/conditions/new' do
    erb :"condition/new"
  end

  get '/weather-dashboard' do
    @max_visibilities = Condition.visibility_highest_rides
    @min_visibilities = Condition.visibility_lowest_rides
    @ave_visibilities = Condition.visibility_average_rides
    @max_wind_speeds = Condition.wind_maximum_rides
    @min_wind_speeds = Condition.wind_minimum_rides
    @ave_wind_speeds = Condition.wind_average_rides
    erb :"condition/dashboard"
  end

  get '/conditions/:id' do
    @condition = Condition.find(params[:id])
    erb :'condition/show'
  end

  post '/conditions' do
    weather = Condition.create!(params[:condition])
    redirect "/conditions/#{weather.id}"
  end

  get '/conditions/:id/edit' do
    @condition = Condition.find(params[:id])

    erb :'condition/edit'
  end

  put '/conditions/:id' do
    @condition = Condition.update(params[:id], params[:condition])

    redirect "conditions/#{@condition.id}"
  end

  delete '/conditions/:id' do
    Condition.destroy(params[:id])

    redirect "/conditions"
  end
end
