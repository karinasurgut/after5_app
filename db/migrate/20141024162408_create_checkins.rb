class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :user_id
      t.integer :venue_id

      t.timestamps
    end
    add_index :checkins, [:user_id, :created_at]
    add_index :checkins, [:user_id, :venue_id]
  end
end
