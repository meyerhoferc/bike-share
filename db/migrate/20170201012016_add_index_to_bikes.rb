class AddIndexToBikes < ActiveRecord::Migration[5.0]
  def change
    add_index :bikes, :bike_number
  end
end
