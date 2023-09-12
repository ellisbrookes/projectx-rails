class Projects < ApplicationRecord
  belongs_to :company
  has_many :team

  validates :name, presence: true
  validates :description, presence: true
  validates :estimated_completion_date, presence: true
  validates :completion_date, presence: true
end
