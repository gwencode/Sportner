class FavoriteSpot < ApplicationRecord
  belongs_to :user
  belongs_to :spot, optional: true
  validates :sport, presence: true

  # geocoded_by :city_spot
  # after_validation :geocode, if: :will_save_change_to_city_spot?

  SPORTS = ["running", "surf"]
end
