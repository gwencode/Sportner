class RunDetail < ApplicationRecord
  belongs_to :itinerary, optional: true
  has_many :events

  validates :type, :distance, :pace, :duration, :location, presence: true

  TYPES = ["footing", "sortie longue", "VMA", "allure spécifique", "fractionné", "trail", "côtes", "marche athlétique", "parcours d'obstacles"]

  has_many_attached :photos
end
