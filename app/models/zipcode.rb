class Zipcode < ActiveRecord::Base
  validates :zip_code, presence: true
  has_many :trips
  validates_uniqueness_of :zip_code
end
