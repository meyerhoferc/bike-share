class Condition < ActiveRecord::Base
  validates :date, presence: true
  has_many :trips
  validates_uniqueness_of :date, scope: :zipcode
end
