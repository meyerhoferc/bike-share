class Condition < ActiveRecord::Base
  validates :date, presence: true
  validates :max_temperature_f, presence: true
  validates :mean_temperature_f, presence: true
  validates :min_temperature_f, presence: true
  validates :mean_humidity, presence: true
  validates :mean_visibility, presence: true
  validates :mean_wind_speed, presence: true
  validates :precipitation_inches, presence: true

end
