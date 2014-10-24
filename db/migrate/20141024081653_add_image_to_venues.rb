class AddImageToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :image, :string, default: "venue.jpg"
  end
end
