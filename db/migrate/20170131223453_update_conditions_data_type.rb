class UpdateConditionsDataType < ActiveRecord::Migration[5.0]
  def change
    remove_column :conditions, :max_temperature_f
    remove_column :conditions, :mean_temperature_f
    remove_column :conditions, :min_temperature_f
    remove_column :conditions, :mean_humidity
    remove_column :conditions, :mean_visibility
    remove_column :conditions, :mean_wind_speed
    remove_column :conditions, :precipitation_inches

    add_column :conditions, :max_temperature_f, :float
    add_column :conditions, :mean_temperature_f, :float
    add_column :conditions, :min_temperature_f, :float
    add_column :conditions, :mean_humidity, :float
    add_column :conditions, :mean_visibility, :float
    add_column :conditions, :mean_wind_speed, :float
    add_column :conditions, :precipitation_inches, :float
  end
end
