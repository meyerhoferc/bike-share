require_relative '../spec_helper'

describe Bike do
  describe "validations" do
    it "is invalid without a number" do
      bike = Bike.create()

      expect(bike).to_not be_valid
    end
  end
end
