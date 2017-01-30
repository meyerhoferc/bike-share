class Zipcode < ActiveRecord::Base
  has_many :trips
  validates_uniqueness_of :zip_code
end
