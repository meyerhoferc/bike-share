require_relative '../spec_helper'

describe "user can edit from index" do
  it "they see the form" do
    Condition.create(date: "01/05/2017",
                      max_temperature_f: "90",
                      mean_temperature_f: "75",
                      min_temperature_f: "19",
                      mean_humidity: "0.50",
                      mean_visibility: "1",
                      mean_wind_speed: "10",
                      precipitation_inches: "4")

    visit("/conditions")
    click_on("Edit")
    expect(current_path).to eq("/conditions/1/edit")

    fill_in("condition[mean_humidity]", with: "0.7")
    fill_in("condition[max_temperature_f]", with: "99")

    click_on("Submit")

    expect(current_path).to eq("/conditions/1")
    within("#weather") do
      expect(page).to have_content("99")
      expect(page).to have_content("0.7")
    end
  end
end

describe "user can edit from show" do
  it "they see the form" do
    weather = Condition.create(date: "01/05/2017",
                              max_temperature_f: "90",
                              mean_temperature_f: "75",
                              min_temperature_f: "19",
                              mean_humidity: "0.50",
                              mean_visibility: "1",
                              mean_wind_speed: "10",
                              precipitation_inches: "4")

    visit("/conditions/#{weather.id}")
    click_on("Edit")
    expect(current_path).to eq("/conditions/#{weather.id}/edit")

    fill_in("condition[min_temperature_f]", with: "25")
    fill_in("condition[precipitation_inches]", with: "1")

    click_on("Submit")

    expect(current_path).to eq("/conditions/1")
    within("#weather") do
      expect(page).to have_content("25")
      expect(page).to have_content("1")
    end
  end
end
