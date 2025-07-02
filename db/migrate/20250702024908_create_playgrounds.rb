class CreatePlaygrounds < ActiveRecord::Migration[8.0]
  def change
    create_table :playgrounds do |t|
      t.string :name
      t.string :address
      t.text :description
      t.decimal :latitude
      t.decimal :longitude
      t.text :amenities
      t.string :age_group
      t.string :opening_hours
      t.string :contact_info

      t.timestamps
    end
  end
end
