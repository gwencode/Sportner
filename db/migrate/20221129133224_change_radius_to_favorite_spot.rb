class ChangeRadiusToFavoriteSpot < ActiveRecord::Migration[7.0]
  def change
    change_column :favorite_spots, :radius, :integer, null: false, default: 1
  end
end
