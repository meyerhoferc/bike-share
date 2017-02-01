require_relative '../spec_helper'

describe "When a user visits show" do
  it "they see one day of weather" do
    weather = Condition.create(date: "01/05/2017",
                      max_temperature_f: "90",
                      mean_temperature_f: "75",
                      min_temperature_f: "19",
                      mean_humidity: "0.50",
                      mean_visibility: "1",
                      mean_wind_speed: "10",
                      precipitation_inches: "4")

      visit("/conditions/#{weather.id}")

      within("#weather") do
        expect(page).to have_content("5/1/2017")
        expect(page).to have_content(weather.max_temperature_f)
        expect(page).to have_content(weather.min_temperature_f)
        expect(page).to have_content(weather.mean_temperature_f)
        expect(page).to have_content(weather.mean_humidity)
        expect(page).to have_content(weather.mean_visibility)
        expect(page).to have_content(weather.mean_wind_speed)
        expect(page).to have_content(weather.precipitation_inches)
    end
  end
end
