class ChangeColumnDefault < ActiveRecord::Migration
  def change
  	change_column :durations, :all_day, :boolean, default: false
  	change_column :deals, :start_date, :date, default: nil
  	change_column :deals, :end_date, :date, default: nil
  end
end
