class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User", foreign_key: :user_id
  belongs_to :spot, optional: true
  belongs_to :run_detail, optional: true

  validates :event_type, :name, :date, :meeting_point, :difficulty, presence: true

  DIFFICULTIES = %i[débutant intermédiaire confirmé]

  has_many_attached :photos
end
