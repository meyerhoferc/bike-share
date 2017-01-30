class ChangesZipcodeToString < ActiveRecord::Migration[5.0]
  def change
    remove_column :zipcodes, :zip_code
    add_column :zipcodes, :zip_code, :string
  end
end
