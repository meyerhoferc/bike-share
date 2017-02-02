class Condition < ActiveRecord::Base
  validates :date, presence: true
  has_many :trips
  validates_uniqueness_of :date, scope: :zipcode

  def self.format_date(date)
    year, month, day = date.split('-')
    [month, day, year].join('/')
    "#{date} 00:00 UTC".."#{date} 23:59 UTC"
  end

  def self.temp_highest_rides
    ranges = [(20...30), (30...40), (40...50), (50...60), (60...70), (70...80), (80...90), (90...100)]
    counts = ranges.map do |range|
      trips = Trip.select("date(start_date), count(start_date)")
                  .joins(:condition)
                  .where("conditions.max_temperature_f" => range)
                  .group("date(start_date)")
      if trips.present?
        max_trip = trips.max_by { |trip| trip.attributes["count"] }
        {
          range: range,
          count: max_trip.attributes["count"],
          date: max_trip.attributes["date"]
        }
      else
        nil
      end
    end.compact
    counts.map { |count| "Temp: #{count[:range]} had #{count[:count]} rides"}
  end
end
