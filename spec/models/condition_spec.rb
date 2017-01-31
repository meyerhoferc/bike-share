require_relative '../spec_helper'

describe Condition do
  describe "validations" do
    it "is invalid without date" do
      weather = Condition.create(max_temperature_f: "90",
                                 mean_temperature_f: "75",
                                 min_temperature_f: "19",
                                 mean_humidity: "0.50",
                                 mean_visibility: "1",
                                 mean_wind_speed: "10",
                                 precipitation_inches: "4")

      expect(weather).to_not be_valid
    end

    it "is invalid without max temp" do
      weather = Condition.create(date: "01/04/2017",
                                 mean_temperature_f: "75",
                                 min_temperature_f: "19",
                                 mean_humidity: "0.50",
                                 mean_visibility: "1",
                                 mean_wind_speed: "10",
                                 precipitation_inches: "4")

      expect(weather).to_not be_valid
    end

    it "is invalid without mean temp" do
      weather = Condition.create(date: "01/01/2017",
                                 max_temperature_f: "90",
                                 min_temperature_f: "19",
                                 mean_humidity: "0.50",
                                 mean_visibility: "1",
                                 mean_wind_speed: "10",
                                 precipitation_inches: "4")
      expect(weather).to_not be_valid
    end

    it "is invalid with min temp" do
      weather = Condition.create(date: "01/01/2017",
                                 max_temperature_f: "90",
                                 mean_temperature_f: "75",
                                 mean_humidity: "0.50",
                                 mean_visibility: "1",
                                 mean_wind_speed: "10",
                                 precipitation_inches: "4")
      expect(weather).to_not be_valid
    end

    it "is invalid with mean humidity" do
      weather = Condition.create(date: "01/01/2017",
                                 max_temperature_f: "90",
                                 mean_temperature_f: "75",
                                 min_temperature_f: "19",
                                 mean_visibility: "1",
                                 mean_wind_speed: "10",
                                 precipitation_inches: "4")
      expect(weather).to_not be_valid
    end

    it "is invalid without mean visibility" do
      weather = Condition.create(date: "01/01/2017",
                                 max_temperature_f: "90",
                                 mean_temperature_f: "75",
                                 min_temperature_f: "19",
                                 mean_humidity: "0.50",
                                 mean_wind_speed: "10",
                                 precipitation_inches: "4")
      expect(weather).to_not be_valid
    end

    it "is invalid without wind speed" do
      weather = Condition.create(date: "01/01/2017",
                                 max_temperature_f: "90",
                                 mean_temperature_f: "75",
                                 min_temperature_f: "19",
                                 mean_humidity: "0.50",
                                 mean_visibility: "1",
                                 precipitation_inches: "4")
      expect(weather).to_not be_valid
    end

    it "is invalid without precipitation" do
      weather = Condition.create(date: "01/01/2017",
                                 max_temperature_f: "90",
                                 mean_temperature_f: "75",
                                 min_temperature_f: "19",
                                 mean_humidity: "0.50",
                                 mean_visibility: "1",
                                 mean_wind_speed: "10")
      expect(weather).to_not be_valid 
    end
  end
end
