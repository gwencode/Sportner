class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User", foreign_key: :user_id
  belongs_to :spot, optional: true
  belongs_to :run_detail, optional: true

  has_many :participations
  has_many :participants, through: :participations, source: :user
  has_many :reviews
  has_many :meteos

  has_one :itinerary, through: :run_detail

  validates :event_type, :name, :date, :meeting_point, :difficulty, presence: true

  EVENT_TYPES = ["course à pied", "surf"]
  DIFFICULTIES = %i[débutant intermédiaire confirmé]

  has_many_attached :photos
end
