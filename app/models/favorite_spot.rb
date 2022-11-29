class FavoriteSpot < ApplicationRecord
  belongs_to :user
  validates :sport, :city_spot, :radius, presence: true
end
