require_relative '../spec_helper'

describe "user goes to /trips/new" do
  it 'they see a form' do
    visit '/trips/new'
    city1 = City.create!(name: 'Denver')
    city1.stations.create(name: 'Cortaro Rd', dock_count: 25, installation_date: '01/01/2017')
    city1.stations.create(name: '5th and Congress', dock_count: 32, installation_date: '01/02/2017')

    fill_in('trip[start_station]', with: "Cortaro Rd")
    fill_in('trip[end_station]', with: "5th and Congress")
    fill_in('trip[zipcode]', with: "85701")
    fill_in('trip[duration]', with: "333")
    fill_in('trip[start_date]', with: "01/02/2017 14:22")
    fill_in('trip[end_date]', with: "01/02/2017 15:33")
    fill_in('trip[bike]', with: "334")
    fill_in('trip[subscription]', with: "subscriber")
    click_on('Submit')

    expect(current_path).to eq('/trips/1')
    within('.card-content') do
      expect(page).to have_content("Cortaro Rd")
      expect(page).to have_content("5th and Congress")
      expect(page).to have_content("85701")
      expect(page).to have_content("2017-02-01 14:22:00 UTC")
    end
  end
end
