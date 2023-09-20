# app/models/team.rb
class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :completion_date presence: true
end
