class RemoveVenueIdFromCheckins < ActiveRecord::Migration
  def change
    remove_column :checkins, :venue_id, :integer
  end
end
