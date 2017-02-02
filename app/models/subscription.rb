class Subscription < ActiveRecord::Base
  validates :account, presence: true
  has_many :trips
  validates_uniqueness_of :account

  def self.subscription_breakdown
    total_subscribers = Trip.where(subscription_id: 1).count.to_f
    total_customers = Trip.where(subscription_id: 2).count.to_f
    total = total_subscribers + total_customers
    subscriber = "Subscribers: #{total_subscribers.to_i}, #{((total_subscribers/total) * 100).to_i}%"
    customer = " Customers: #{total_customers.to_i}, #{((total_customers/total) * 100).to_i}%"
    subscriber + customer
  end
end
