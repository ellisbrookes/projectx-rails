class Projects < ApplicationRecord
  belongs_to :company
  has_many :team

  validates :name, presence: true
  validates :description, presence: true
  validate :estimated_completion_date, presence: true
  validate :completion_date, presence: true
end
