require_relative '../spec_helper'

describe Trip do
  describe "validations" do
    it "is invalid without a duration" do
      skip
      subscription = Subscription.create(account: "subscriber")
      city = City.create(name: "San Jose")
      station = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(start_date: '01/01/2017 14:14',
                        start_station_id: station.id,
                        end_date: '01/01/2017 15:30',
                        end_station_id: station.id,
                        bike_id: bike.id,
                        subscription_id: subscription.id,
                        zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end

    it 'is invalid without a start date' do
      skip
      subscription = Subscription.create(account: "Subscriber")
      city = City.create(name: "San Jose")
      station = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      bike = Bike.create(bike_number: 28)
      zipcode = Zipcode.create(zip_code: 85701)
      trip = Trip.create(duration: '100',
                        start_station_id: station.id,
                        end_date: '01/01/2017 15:30',
                        end_station_id: station.id,
                        bike_id: bike.id,
                        subscription_id: subscription.id,
                        zipcode_id: zipcode.id)

      expect(trip).to_not be_valid
    end
  end
end
