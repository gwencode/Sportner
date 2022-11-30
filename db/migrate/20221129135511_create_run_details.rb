class CreateRunDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :run_details do |t|
      t.string :type
      t.float :distance
      t.string :pace
      t.integer :duration
      t.integer :elevation
      t.string :location
      t.text :live_itinerary
      t.references :itinerary, foreign_key: true

      t.timestamps
    end
  end
end
