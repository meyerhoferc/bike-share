require_relative '../spec_helper'

describe Subscription do
  describe "validations" do
    it "is invalid without an account" do
      subscription = Subscription.create()

      expect(subscription).to_not be_valid
    end

    it 'is valid with an account' do
      subscription = Subscription.create(account: "Subscriber")

      expect(subscription).to be_valid
    end
  end

  describe '.subscription_breakdown' do
    it 'returns a breakdown of the subscription types available' do
      subscription = Subscription.create(account: "subscriber")
      subscription2 = Subscription.create(account: "customer")
      city = City.create(name: "San Jose")
      station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
        installation_date: '01/01/2017')
      station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
        installation_date: '01/03/2017')
      bike = Bike.create(bike_number: 28)
      bike2 = Bike.create(bike_number: 38)
      zipcode = Zipcode.create(zip_code: 85701)
      Trip.create!(duration: 88,
                         start_station_id: station_1.id,
                         start_date: '01/01/2017 14:14',
                         end_date: '01/01/2017 15:30',
                         end_station_id: station_2.id,
                         subscription_id: subscription.id,
                         bike_id: bike.id,
                         zipcode_id: zipcode.id)
      Trip.create!(duration: 77,
                        start_station_id: station_1.id,
                        start_date: '01/01/2017 14:14',
                        end_date: '01/03/2017 15:30',
                        end_station_id: station_2.id,
                        subscription_id: subscription.id,
                        bike_id: bike2.id,
                        zipcode_id: zipcode.id)
     Trip.create!(duration: 77,
                       start_station_id: station_1.id,
                       start_date: '01/04/2017 14:14',
                       end_date: '01/03/2017 15:30',
                       end_station_id: station_2.id,
                       subscription_id: subscription2.id,
                       bike_id: bike2.id,
                       zipcode_id: zipcode.id)

      expect(Subscription.subscription_breakdown).to eq('Subscribers: 2, 66% Customers: 1, 33%')
    end
  end
end
