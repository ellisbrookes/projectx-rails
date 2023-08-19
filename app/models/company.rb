class Company < ApplicationRecord
  belongs_to :user
  has_many :teams

  validates :name, presence: true
  validates :description, presence: true
  validates :email, presence: true
end