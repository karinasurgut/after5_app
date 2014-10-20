class AddFullAddressToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :full_address, :string
  end
end
