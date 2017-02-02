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
  belongs_to :condition


  def self.correct_rides_grammar(statement, count)
    return statement.gsub('rides', 'ride') if count == 1
    statement
  end

  def self.most_frequent_destination
    id = group(:end_station_id).order("count(*) desc").limit(1).pluck(:end_station_id).first
    if id
      Station.find(id).name
    end
  end

  def self.most_frequent_origin
    id = group(:start_station_id).order("count(*) desc").limit(1).pluck(:start_station_id).first
    if id
      Station.find(id).name
    end
  end

  def self.reject_data(count_by_months)
    count_by_months.reject { |month, count| count.nil? || count == 0 }
  end

  def self.format_monthly_trip_count(count_by_months)
    count_by_months = reject_data(count_by_months)
    result = []
    total = 0
    count_by_months.each do |month, count|
      total += count
      result << "#{month} had #{count} rides, total: #{total}"
    end
    result
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

  def self.busiest_date_time
    group('start_date').order('count(*) desc').limit(1).pluck(:start_date).first
  end

  def self.slowest_date_time
    group('start_date').order('count(*) asc').limit(1).pluck(:start_date).first
  end

  def self.busiest_day
    date_time = busiest_date_time
    count = Trip.where(start_date: date_time).count
    correct_rides_grammar("#{date_time.month}/#{date_time.day}/#{date_time.year} had #{count} rides", count)
  end

  def self.weather_for_busiest_day
    date = busiest_date_time.to_date
    Condition.where("date(date) = ?", date).limit(1).first
  end

  def self.slowest_day
    date_time = slowest_date_time
    count = Trip.where(start_date: date_time).count
    correct_rides_grammar("#{date_time.month}/#{date_time.day}/#{date_time.year} had #{count} rides", count)
  end

  def self.weather_for_slowest_day
    date = slowest_date_time.to_date
    Condition.where("date(date) = ?", date).limit(1).first
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

  def self.determine_number_of_trips_for_month(month, year)
    years = [2013, 2014]
    if month == 12 && year != years.last
    elsif month == 12 && year == years.last
      trips = Trip.where(start_date: "#{month}/01/#{year} 00:00 UTC").count
    else
      trips = Trip.where(start_date: "#{month}/01/#{year} 00:00 UTC"..."#{month + 1}/01/#{year} 00:00 UTC").count
    end
  end

  def self.month_by_month
    months = (1..12).to_a
    years = [2013, 2014]
    months_years = months.map { |month| [month, years[0]]}
    months.each { |month| months_years << [month, years[1]]}
    count_by_months = {}
    months_years.each do |month, year|
      trips = determine_number_of_trips_for_month(month, year)
      count_by_months[(month.to_s + '/' + year.to_s)] = trips
    end
    format_monthly_trip_count(count_by_months)
  end
end
