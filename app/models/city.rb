class City < ActiveRecord::Base
  has_many :stations
  validates_uniqueness_of :name
end
