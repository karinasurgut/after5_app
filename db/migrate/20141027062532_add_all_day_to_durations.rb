class AddAllDayToDurations < ActiveRecord::Migration
  def change
    add_column :durations, :all_day, :boolean, default: false
  end
end
