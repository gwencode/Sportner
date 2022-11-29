class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :run_details

  validates :data, presence: true
end
