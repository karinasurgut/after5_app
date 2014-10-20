class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.string :content
      t.integer :venue_id

      t.timestamps
    end
    add_index :deals, :venue_id
  end
end
