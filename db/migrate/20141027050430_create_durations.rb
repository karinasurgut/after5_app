class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
      t.integer :deal_id
      t.time :from_time
      t.time :till_time
      t.integer :week_day

      t.timestamps
    end
    add_index :durations, [:from_time, :till_time]
    add_index :durations, :deal_id
    add_index :durations, [:week_day, :from_time, :till_time]
  end
end
