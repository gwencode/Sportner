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
  has_many_attached :photos

  has_one :itinerary, through: :run_detail
  has_one :chatroom

  accepts_nested_attributes_for :run_detail

  validates :event_type, :name, :date, :meeting_point, :difficulty, presence: true

  geocoded_by :meeting_point
  after_validation :geocode, if: :will_save_change_to_meeting_point?

  EVENT_TYPES = ["running", "surf"]
  DIFFICULTIES = %i[débutant intermédiaire confirmé]

  def call_weather_event_api
    url = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=85ca93f406684910b42131430220512&q=#{self.latitude},#{self.longitude}&format=json&num_of_days=1&date=#{self.date.year}-#{self.date.month}-#{self.date.day}&includelocation=yes&tp=6&lang=fr" if self.event_type == "running"
    url = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=85ca93f406684910b42131430220512&q=#{self.spot.latitude},#{self.spot.longitude}&format=json&num_of_days=1&date=#{self.date.year}-#{self.date.month}-#{self.date.day}&includelocation=yes&tp=6&lang=fr" if self.event_type == "surf"
    weather_serialized = URI.open(url).read
    weather = JSON.parse(weather_serialized, symbolize_names: true)
  end
end
