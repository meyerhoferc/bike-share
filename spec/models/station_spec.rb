require_relative '../spec_helper'

describe Station do
  describe "validations" do
    it "invalid without a name" do
      station = Station.create(dock_count: 22, city_id: 3, installation_date: "01/01/2017")

      expect(station).to_not be_valid
    end

    it "invalid without a dock count" do
      station = Station.create(name: "Big Deal", city_id: 3, installation_date: "01/01/2017")

      expect(station).to_not be_valid
    end

    it "invalid without a city_id" do
      station = Station.create( name: "Art Center", dock_count: 22, installation_date: "01/01/2017")

      expect(station).to_not be_valid
    end

    it "invalid without a installation date" do
      station = Station.create(name: "Corner Store", dock_count: 22, city_id: 3)

      expect(station).to_not be_valid
    end
  end
end
