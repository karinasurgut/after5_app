class AddDateToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :start_date, :date#, default: Date.today
    add_column :deals, :end_date, :date#, default: Date.today + 50.years
  end
end
