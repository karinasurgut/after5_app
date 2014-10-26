class AddIndexToCheckins < ActiveRecord::Migration
  def change
  	add_index :checkins, :deal_id
  	add_index :checkins, [:user_id, :deal_id]
  	add_index :checkins, :user_id
  	add_index :checkins, :created_at
  end
end
