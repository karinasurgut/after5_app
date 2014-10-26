class AddDealIdToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :deal_id, :integer
  end
end
