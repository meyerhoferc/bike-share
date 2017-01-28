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
   @station = Station.create(params[:station])

   redirect '/stations/#{@station.id}'
 end

 get '/stations/:id/edit' do
   @station = Station.find(params[:id])

   erb :'station/edit'
 end

 put '/stations/:id' do
   @station = Station.update(params[:id], params[:station])

   redirect '/stations/#{@station.id}'
 end

 delete '/stations/:id' do
   @station = Station.destroy(params[:id])

   redirect '/stations'
 end

end
