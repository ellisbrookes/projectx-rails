# app/models/team.rb
class Task < ApplicationRecord
  belongs_to :reporter, class_name: "User"
  belongs_to :assigned_to, class_name: "User"
  belongs_to :project, required: false
  belongs_to :team, required: false

  has_many :sub_tasks
  has_many :comments

  validates :name, presence: true
  validates :description, presence: true
  validates :due_date, presence: true
  validates :status, presence: true
end
