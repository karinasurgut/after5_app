class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.integer :venue_id
      t.integer :day
      t.time :open_time
      t.time :close_time
      t.boolean :closed

      t.timestamps
    end

    add_index :hours, [:venue_id, :day]
    add_index :hours, :venue_id
    add_index :hours, [:venue_id, :created_at]
  end
end