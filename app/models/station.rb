class Station < ActiveRecord::Base
  validates :name, presence: true
  validates :dock_count, presence: true
  validates :city, presence: true
  validates :installation_date, presence: true
  belongs_to :city

  def self.average_bikes
    average(:dock_count).round(1)
  end
end
