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

  def self.most_ridden
    bike_id = group('bike_id').order('count(*)').pluck(:bike_id).last
    count = Trip.where(bike_id: bike_id).count
    correct_rides_grammar("Bike #{Bike.find(bike_id).bike_number} had #{count} rides", count)
  end

  def self.least_ridden
    bike_id = group('bike_id').order('count(*)').pluck(:bike_id).first
    count = Trip.where(bike_id: bike_id).count
    correct_rides_grammar("Bike #{Bike.find(bike_id).bike_number} had #{count} rides", count)
  end
end
