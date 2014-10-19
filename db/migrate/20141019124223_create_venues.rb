class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :street
      t.string :suburb
      t.string :region
      t.string :website

      t.timestamps
    end
  end
end
