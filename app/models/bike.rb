class Bike < ActiveRecord::Base
  has_many :trips
  validates :bike_number, presence: true
  validates_uniqueness_of :bike_number


  def self.correct_rides_grammar(statement, count)
    return statement.gsub('rides', 'ride') if count == 1
    statement
  end

  def self.most_ridden
    bike = select("bikes.bike_number, count(trips.bike_id) as number_of_trips")
      .joins(:trips).group("bikes.bike_number")
      .order("number_of_trips desc")
      .limit(1).first
    correct_rides_grammar("Bike #{bike.bike_number} had #{bike.number_of_trips} rides", bike.number_of_trips)
  end

   def self.least_ridden
     bike = select("bikes.bike_number, count(trips.bike_id) as number_of_trips")
      .joins(:trips).group("bikes.bike_number")
      .order("number_of_trips asc")
      .limit(1).first
    correct_rides_grammar("Bike #{bike.bike_number} had #{bike.number_of_trips} rides", bike.number_of_trips)
   end
end
