class RunDetail < ApplicationRecord
  belongs_to :itinerary, optional: true
  has_many :events

  validates :run_type, :distance, :pace, :duration, :location, presence: true

  RUN_TYPES = ["footing", "sortie longue", "VMA", "allure spécifique", "fractionné", "trail", "côtes", "marche athlétique", "parcours d'obstacles"]

  # has_many_attached :photos
end
