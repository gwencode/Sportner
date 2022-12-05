class Event < ApplicationRecord
  require "json"
  require "open-uri"
  belongs_to :organizer, class_name: "User", foreign_key: :user_id
  belongs_to :spot, optional: true
  belongs_to :run_detail, optional: true

  has_many :participations
  has_many :participants, through: :participations, source: :user
  has_many :reviews
  has_many :meteos

  has_one :itinerary, through: :run_detail

  validates :event_type, :name, :date, :meeting_point, :difficulty, presence: true

  geocoded_by :meeting_point
  after_validation :geocode, if: :will_save_change_to_meeting_point?

  EVENT_TYPES = ["running", "surf"]
  DIFFICULTIES = %i[débutant intermédiaire confirmé]

  has_many_attached :photos
  
  def call_weather_api
    url = "https://api.worldweatheronline.com/premium/v1/marine.ashx?key=85ca93f406684910b42131430220512&q=#{self.latitude},#{self.longitude}&format=json&includelocation=yes&tide=yes&tp=6"
    weather_serialized = URI.open(url).read
    weather = JSON.parse(weather_serialized, symbolize_names: true)
  end
end
