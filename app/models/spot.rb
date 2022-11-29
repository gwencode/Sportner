class Spot < ApplicationRecord
  validates :location, presence: true
end
