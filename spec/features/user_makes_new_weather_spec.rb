require_relative '../spec_helper'

describe "user goes to /conditions/new" do
  it "they see a form" do
    visit "/conditions/new"

    fill_in("condition[date]", with: "06/06/2016")
    fill_in("condition[max_temperature_f]", with: "92")
    fill_in("condition[mean_temperature_f]", with: "88")
    fill_in("condition[min_temperature_f]", with: "60")
    fill_in("condition[mean_humidity]", with: "0.72")
    fill_in("condition[mean_visibility]", with: "1")
    fill_in("condition[mean_wind_speed]", with: "10")
    fill_in("condition[precipitation_inches]", with: "2.3")
    click_on("Submit")

    expect(current_path).to eq("/conditions/1")
    within("#weather") do
      
      expect(page).to have_content("92")
      expect(page).to have_content("2.3")
      expect(page).to have_content("6/6/2016")
    end
  end
end
