class AddSpotReferencesToFavoriteSpots < ActiveRecord::Migration[7.0]
  def change
    add_reference :favorite_spots, :spot, foreign_key: true
  end
end
