class AddIndexToZipcode < ActiveRecord::Migration[5.0]
  def change
    add_index :zipcodes, :zip_code
  end
end
