class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :lockable, :timeoutable, :validatable, :invitable

  has_one_attached :avatar

  belongs_to :company
  has_many :team_members
  has_many :teams, through: :team_members
end
