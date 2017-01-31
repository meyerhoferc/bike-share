class FixesTimestampForConditions < ActiveRecord::Migration[5.0]
  def change
    remove_column :conditions, :created_at
    remove_column :conditions, :updated_at
    add_timestamps(:conditions, null: false)
  end
end
