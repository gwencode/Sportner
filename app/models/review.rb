class Review < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :rating_event, :rating_difficulty, :rating_spot, presence: true
end
