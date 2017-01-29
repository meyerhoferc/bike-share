require_relative '../spec_helper'

describe "user can edit from index" do
  it "they see a form" do
    subscription = Subscription.create(account: "subscriber")
    subscription_2 = Subscription.create(account: "guest")
    city = City.create(name: "San Jose")
    station_1 = city.stations.create(name: "Golden Gate", dock_count: 22,
      installation_date: '01/01/2017')
    station_2 = city.stations.create(name: "Aquarium", dock_count: 28,
      installation_date: '01/03/2017')
    bike = Bike.create(bike_number: 28)
    zipcode = Zipcode.create(zip_code: 85701)
    zipcode_1 = Zipcode.create(zip_code: 90210)
    trip = Trip.create(duration: 102,
                       start_date: '01/01/2017 14:14',
                       start_station_id: station_1.id,
                       end_date: '01/01/2017 15:30',
                       end_station_id: station_2.id,
                       bike_id: bike.id,
                       subscription_id: subscription.id,
                       zipcode_id: zipcode.id)

    visit("/trips")
    click_on("Edit")
    expect(current_path).to eq("/trips/1/edit")

    fill_in('trip[zipcode]', with: zipcode_1.zip_code)
    fill_in('trip[subscription]', with: subscription_2.account)

    click_on("Submit")

    expect(current_path).to eq("/trips/1")
    within('.card-content') do
      expect(page).to have_content(zipcode_1.zip_code)
      expect(page).to have_content(subscription_2.account)
    end

  end
end
