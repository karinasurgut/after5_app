class AddPhoneLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :location, :string
  end
end
