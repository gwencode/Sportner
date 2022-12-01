class FavoriteSpot < ApplicationRecord
  belongs_to :user
  validates :sport, :city_spot, :radius, presence: true

  geocoded_by :city_spot
  after_validation :geocode, if: :will_save_change_to_city_spot?

  SPORTS = ["course à pied", "surf"]
end
