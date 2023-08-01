# app/models/team.rb
class Team < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :description, presence: true
  validates :team_email, presence: true
end
