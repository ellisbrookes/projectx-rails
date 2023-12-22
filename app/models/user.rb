class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :lockable, :timeoutable, :validatable

  has_one_attached :avatar

  has_many :companies, dependent: :destroy
  has_many :team_members
  has_many :teams, through: :team_members
end
