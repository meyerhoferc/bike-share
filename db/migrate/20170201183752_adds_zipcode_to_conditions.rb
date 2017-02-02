class AddsZipcodeToConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :conditions, :zipcode, :string
  end
end
