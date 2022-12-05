class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User", foreign_key: :user_id
  belongs_to :spot, optional: true
  belongs_to :run_detail, optional: true

  has_many :participations
  has_many :participants, through: :participations, source: :user
  has_many :reviews
  has_many :meteos
  has_many_attached :photos

  has_one :itinerary, through: :run_detail

  accepts_nested_attributes_for :run_detail

  validates :event_type, :name, :date, :meeting_point, :difficulty, presence: true

  geocoded_by :meeting_point
  after_validation :geocode, if: :will_save_change_to_meeting_point?

  EVENT_TYPES = ["running", "surf"]
  DIFFICULTIES = %i[débutant intermédiaire confirmé]
end
