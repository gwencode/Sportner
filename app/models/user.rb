class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorite_spots
  has_many :itineraries
  has_many :organized_events, class_name: "Event"
  has_many :participations
  has_many :participated_events, through: :participations, source: :event
  has_many :reviews

  validates :first_name, :last_name, presence: true
  validates :address, :zipcode, :city, presence: true, on: :update
  validate :one_sport, on: :update
  validate :need_surf_level, on: :update
  validate :need_run_level, on: :update

  # has_one_attached :avatar

  LEVELS = %i[débutant intermédiaire confirmé]

  def one_sport
    errors.add(:sport, "Vous devez choisir au moins un sport") unless runner || surfer
  end

  def need_surf_level
    errors.add(:surf_level, "Vous devez définir votre niveau") unless surfer && surf_level
  end

  def need_run_level
    errors.add(:run_level, "Vous devez définir votre niveau") unless runner && run_level
  end
end
