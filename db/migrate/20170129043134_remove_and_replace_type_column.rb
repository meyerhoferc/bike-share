class RemoveAndReplaceTypeColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :subscriptions, :account
    add_column :subscriptions, :account, :string
  end
end
