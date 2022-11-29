class CreateFavoriteSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_spots do |t|
      t.string :sport
      t.string :city_spot
      t.integer :radius
      t.references :user, null:false, foreign_key: true

      t.timestamps
    end
  end
end
