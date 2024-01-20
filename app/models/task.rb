# app/models/team.rb
class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  belongs_to :reporter, class_name: "User"
  belongs_to :assigned_to, class_name: "User"
  belongs_to :project
  belongs_to :team

  has_many :sub_tasks
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :due_date, presence: true
  validates :status, presence: true
end
