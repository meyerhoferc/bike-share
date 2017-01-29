class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.integer :duration
      t.datetime :start_date
      t.integer :start_station_id
      t.datetime :end_date
      t.integer :end_station_id
      t.integer :bike_id
      t.integer :subscription_id
      t.integer :zipcode_id

      t.timestamps null: false
    end
  end
end
