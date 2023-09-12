class Project < ApplicationRecord
  belongs_to :company
  belongs_to :team

  validates :name, presence: true
  validates :description, presence: true
  validates :estimated_completion_date, presence: true
  validates :completion_date, presence: true
end
