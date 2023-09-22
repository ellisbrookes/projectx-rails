# app/models/team.rb
class Task < ApplicationRecord
  belongs_to :user, foreign_key: "assigned_to"
  belongs_to :project
  # has_one :assigned_to, class_name: "User", foreign_key: "user_id"

  validates :name, presence: true
  validates :description, presence: true
  validates :due_date, presence: true
  # validates :assigned_to, presence: true
  validates :status, presence: true
end
