class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :address, :zipcode, :city, presence: true
  validate :one_sport

  def one_sport
    errors.add(:sport, "Vous devez choisir au moins un sport") unless runner || surfer
  end
end
