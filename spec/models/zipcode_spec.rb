require_relative '../spec_helper'

describe Zipcode do
  describe "validations" do
    it "is invalid without a zipcode" do
      zipcode = Zipcode.create()

      expect(zipcode).to_not be_valid
    end
  end
end
