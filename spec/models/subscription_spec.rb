require_relative '../spec_helper'

describe Subscription do
  describe "validations" do
    it "is invalid without an account" do
      subscription = Subscription.create()

      expect(subscription).to_not be_valid
    end

    it 'is valid with an account' do
      subscription = Subscription.create(account: "Subscriber")

      expect(subscription).to be_valid
    end
  end
end
