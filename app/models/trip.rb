class Trip < ActiveRecord::Base
  validates :duration, presence: true
  validates :start_date, presence: true
  validates :start_station_id, presence: true
  validates :end_date, presence: true
  validates :end_station_id, presence: true
  validates :bike_id, presence: true
  validates :subscription_id, presence: true
  validates :zipcode_id, presence: true

  belongs_to :start_station_id
  belongs_to :end_station_id
  belongs_to :bike_id
  belongs_to :subscription_id
  belongs_to :zipcode_id
end
