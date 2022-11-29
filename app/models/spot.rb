class Spot < ApplicationRecord
  validates :location, presence: true

  has_many :events

  has_many_attached :photos
end
