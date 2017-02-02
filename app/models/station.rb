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

  def day_with_most_starts
    date = beginning_trips.group(:start_date).order('count(*)').pluck(:start_date).last
    count = beginning_trips.group(:start_date).order('count(*)').pluck(:start_date).count
    "#{format_date(date)} had #{count} starts" if date
  end

  def most_frequent_destination
    beginning_trips.most_frequent_destination
  end

  def most_frequent_origin
    ending_trips.most_frequent_origin
    id = beginning_trips.group(:end_station_id).order("count(*) desc").limit(1).pluck(:end_station_id).first
    Station.find(id).name if id
  end

  def most_frequent_origin
    id = ending_trips.group(:start_station_id).order("count(*) desc").limit(1).pluck(:start_station_id).first
    Station.find(id).name if id
  end

  def rides_ended
    ending_trips.count
  end


  def format_date(date)
    x = date.to_s.split("-")
    "#{x[1]}/#{x[2][0..1]}/#{x[0]}"
  end

  def rides_started
    beginning_trips.count
  end

  def most_frequent_zipcode
    id = beginning_trips.group(:zipcode_id).order("count(*) desc").limit(1).pluck(:zipcode_id).first
    Zipcode.find(id).zip_code if id
  end

  def most_frequent_bike
    id = beginning_trips.group(:bike_id).order("count(*) desc").limit(1).pluck(:bike_id).first
    Bike.find(id).bike_number if id
  end
end
