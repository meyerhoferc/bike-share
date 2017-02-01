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


  def self.correct_rides_grammar(statement, count)
    return statement.gsub('rides', 'ride') if count == 1
    statement
  end

  def self.shortest_ride
    minimum(:duration)
  end

  def self.longest_ride
    maximum(:duration)
  end

  def self.average_duration
    average(:duration)
  end

  def self.busiest_day
    date_time = group('start_date').order('count(*)').pluck(:start_date).last
    count = Trip.where(start_date: date_time).count
    correct_rides_grammar("#{date_time.month}/#{date_time.day}/#{date_time.year} had #{count} rides", count)
  end

  def self.slowest_day
    date_time = group('start_date').order('count(*)').pluck(:start_date).first
    count = Trip.where(start_date: date_time).count
    correct_rides_grammar("#{date_time.month}/#{date_time.day}/#{date_time.year} had #{count} rides", count)
  end

  def self.most_common_ending_station
    station_id = select("trips.end_station_id, count(trips.end_station_id) as frequency")
    .group("trips.end_station_id").order("frequency desc")
    .limit(1).first
    Station.find(station_id.end_station_id).name
  end

  def self.most_common_starting_station
    station_id = select("trips.start_station_id, count(trips.start_station_id) as frequency")
    .group("trips.start_station_id").order("frequency desc")
    .limit(1).first
    Station.find(station_id.start_station_id).name
  end
end
