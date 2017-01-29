class Subscription < ActiveRecord::Base
  validates :account, presence: true
  has_many :trips
  validates_uniqueness_of :account
end
