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

  def self.month_by_month
    months = {1 => "January", 2 => "February", 3 => "March", 4 => "April",
      5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September",
      10 => "October", 11 => "November", 12 =>  "December"}
    january = Trip.where(start_date: '01/01/2013 00:00 UTC'...'02/01/2013 00:00 UTC')
    february = Trip.where(start_date: '02/01/2013 00:00 UTC'...'03/01/2013 00:00 UTC')
    march = Trip.where(start_date: '03/01/2013 00:00 UTC'...'04/01/2013 00:00 UTC')
    april = Trip.where(start_date: '04/01/2013 00:00 UTC'...'05/01/2013 00:00 UTC')
    may = Trip.where(start_date: '05/01/2013 00:00 UTC'...'06/01/2013 00:00 UTC')
    june = Trip.where(start_date: '06/01/2013 00:00 UTC'...'07/01/2013 00:00 UTC')
    july = Trip.where(start_date: '07/01/2013 00:00 UTC'...'06/01/2013 00:00 UTC')
    august = Trip.where(start_date: '08/01/2013 00:00 UTC'...'07/01/2013 00:00 UTC')
    september = Trip.where(start_date: '09/01/2013 00:00 UTC'...'10/01/2013 00:00 UTC')
    october = Trip.where(start_date: '10/01/2013 00:00 UTC'...'11/01/2013 00:00 UTC')
    november = Trip.where(start_date: '11/01/2013 00:00 UTC'...'12/01/2013 00:00 UTC')
    december = Trip.where(start_date: '12/01/2013 00:00 UTC'...'01/01/2014 00:00 UTC')

    january = "January: #{january.count} rides, total: #{jan_total}"
    february = " February: #{february.count} rides, total: #{feb_total}"
    march = " March: #{march.count} rides, total: #{march_total}"
    april = " April: #{april.count} rides, total: #{april_total}"
    may = " May: #{may.count} rides, total: #{may.total}"
    january + february + march + april + may
    # require 'pry'; binding.pry
  end
end
