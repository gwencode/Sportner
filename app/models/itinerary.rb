class Itinerary < ApplicationRecord
  belongs_to :user

  validates :data, presence: true
end
