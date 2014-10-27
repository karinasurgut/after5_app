class AddIndexToDeal < ActiveRecord::Migration
  def change
  	add_index :deals, [:start_date,:end_date]
  end
end
