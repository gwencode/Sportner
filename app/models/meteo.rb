class Meteo < ApplicationRecord
  belongs_to :event

  validates :report_datetime, :weather, :temperature, :wind_direction, presence: true
  validate :wind

  def wind
    errors.add(:wind, "Il faut la vitesse du vent en km/h ou noeuds") unless wind_km || wind_kt
  end
end
