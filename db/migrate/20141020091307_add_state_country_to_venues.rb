class AddStateCountryToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :state, :string, default: "NSW"
    add_column :venues, :country, :string, default: "Australia"
  end
end
