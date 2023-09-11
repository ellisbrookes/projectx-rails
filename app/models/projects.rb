class Projects < ApplicationRecord
  belongs_to :company
  has_many :team_members

  validates :name, presence: true
  validates :description, presence: true
end