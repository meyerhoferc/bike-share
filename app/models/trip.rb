class Trip < ActiveRecord::Base
  validates :duration, presence: true
  validates :start_date, presence: true
  validates :start_station, presence: true
  validates :end_date, presence: true
  validates :end_station, presence: true
  validates :bike, presence: true
  validates :subscription, presence: true

  belongs_to :start_station, class_name: 'Station', foreign_key: :start_station_id
  belongs_to :end_station, class_name: 'Station', foreign_key: :end_station_id
  belongs_to :bike
  belongs_to :subscription
  belongs_to :zipcode

  def self.shortest_ride
    minimum(:duration)
  end
end
