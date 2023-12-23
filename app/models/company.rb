class Company < ApplicationRecord
  has_many :users
  has_many :teams, dependent: :destroy
  has_many :projects

  validates :name, presence: true
  validates :description, presence: true
  validates :email, presence: true
end
