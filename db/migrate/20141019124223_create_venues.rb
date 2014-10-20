class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, default: "", unique: true
      t.string :phone, default: ""
      t.string :email, default: ""
      t.string :street, default: ""
      t.string :suburb, default: ""
      t.string :region, default: ""
      t.string :website, default: ""

      t.timestamps
    end
  end
end
