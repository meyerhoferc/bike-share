class Subscription < ActiveRecord::Base
  validates :type, presence: true
  has_many :trips
  validates_uniqueness_of :type
end
