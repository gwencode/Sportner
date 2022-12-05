class Spot < ApplicationRecord
  require "json"
  require "open-uri"

  validates :location, presence: true

  has_many :events

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many_attached :photos


  def call_weather_api
    url = "https://api.worldweatheronline.com/premium/v1/marine.ashx?key=85ca93f406684910b42131430220512&q=#{self.latitude},#{self.longitude}&format=json&includelocation=yes&tide=yes&tp=6"
    weather_serialized = URI.open(url).read
    weather = JSON.parse(weather_serialized, symbolize_names: true)
  end
end
