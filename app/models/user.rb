class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorite_spots
  has_many :itineraries

  validates :first_name, :last_name, :address, :zipcode, :city, presence: true
  validate :one_sport

  has_one_attached :avatar

  LEVELS = %i[débutant intermédiaire confirmé]

  def one_sport
    errors.add(:sport, "Vous devez choisir au moins un sport") unless runner || surfer
  end
end
