class RunDetail < ApplicationRecord
  belongs_to :itinerary, optional: true
  has_many :events

  validates :run_type, :distance, :pace, :duration, :location, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  RUN_TYPES = ["footing", "sortie longue", "VMA", "allure spécifique", "fractionné", "trail", "côtes", "marche athlétique", "parcours d'obstacles"]

  # has_many_attached :photos
end
