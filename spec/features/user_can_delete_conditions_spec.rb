require_relative '../spec_helper'

describe "user deletes conditions" do
  it "from index" do
    Condition.create(date: "01/05/2017",
                      max_temperature_f: "90",
                      mean_temperature_f: "75",
                      min_temperature_f: "19",
                      mean_humidity: "0.50",
                      mean_visibility: "1",
                      mean_wind_speed: "10",
                      precipitation_inches: "4")

    visit "/conditions"
    click_on("Delete")

    expect(Condition.count).to eq(0)
    expect(current_path).to eq("/conditions")
  end
end
