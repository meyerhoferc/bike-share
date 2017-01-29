class Bike < ActiveRecord::Base
  has_many :trips
  validates :bike_number, presence: true
  validates_uniqueness_of :bike_number
end
