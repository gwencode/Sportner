class Spot < ApplicationRecord
  validates :location, presence: true

  has_many :events

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # has_many_attached :photos
end
