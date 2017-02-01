class Station < ActiveRecord::Base
  validates :name, presence: true
  validates :dock_count, presence: true
  validates :city, presence: true
  validates :installation_date, presence: true
  belongs_to :city
  has_many :beginning_trips, inverse_of: :start_station, class_name: "Trip", foreign_key: :start_station_id
  has_many :ending_trips, inverse_of: :end_station, class_name: "Trip", foreign_key: :end_station_id

  def self.average_bikes
    average(:dock_count).round(1)
  end

  def self.fewest_bikes
    minimum(:dock_count)
  end

  def self.name_fewest_bikes
    self.where(dock_count: minimum(:dock_count)).map do |station|
      station.name
    end.join
  end

  def self.most_bikes
    maximum(:dock_count)
  end

  def self.name_most_bikes
    self.where(dock_count: maximum(:dock_count)).map do |station|
      station.name
    end.join
  end

  def self.newest_station
    max_date = maximum(:installation_date)
    station_name = self.find_by(installation_date: maximum(:installation_date)).name
    "#{station_name}: #{max_date.month}/#{max_date.day}/#{max_date.year}"
  end

  def self.oldest_station
    min_date = minimum(:installation_date)
    station_name = self.find_by(installation_date: minimum(:installation_date)).name
    "#{station_name}: #{min_date.month}/#{min_date.day}/#{min_date.year}"
  end

  def most_frequent_destination
    beginning_trips.most_frequent_destination
  end

  def most_frequent_origin
    ending_trips.most_frequent_origin
  end

  def rides_ended
    ending_trips.count
  end
end
