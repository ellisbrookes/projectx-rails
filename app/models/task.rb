# app/models/team.rb
class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :completion_date, presence: true
  validates :assigned_to, presence: true
  validates :status, presence: true
end
