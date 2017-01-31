require_relative '../spec_helper'

describe "When a user visits conditions/index" do
  it "they see all weather" do
    Condition.create(date: "01/05/2017",
                      max_temperature_f: "90",
                      mean_temperature_f: "75",
                      min_temperature_f: "19",
                      mean_humidity: "0.50",
                      mean_visibility: "1",
                      mean_wind_speed: "10",
                      precipitation_inches: "4")

    Condition.create(date: "02/11/2016",
                      max_temperature_f: "90",
                      mean_temperature_f: "75",
                      min_temperature_f: "19",
                      mean_humidity: "0.50",
                      mean_visibility: "1",
                      mean_wind_speed: "10",
                      precipitation_inches: "4")

    Condition.all.each do |condition|
      visit('/conditions')

      expect(page).to have_content(condition.date)
      expect(page).to have_content(condition.max_temperature_f)
      expect(page).to have_content(condition.min_temperature_f)
      expect(page).to have_content(condition.mean_temperature_f)
      expect(page).to have_content(condition.mean_humidity)
      expect(page).to have_content(condition.mean_visibility)
      expect(page).to have_content(condition.mean_wind_speed)
      expect(page).to have_content(condition.precipitation_inches)
    end
  end
end
