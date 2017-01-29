require_relative '../spec_helper'

describe Subscription do
  describe "validations" do
    it "is invalid without a type" do
      subscription = Subscription.create()

      expect(subscription).to_not be_valid
    end
  end
end
