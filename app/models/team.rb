# app/models/team.rb
class Team < ApplicationRecord
  belongs_to :company
  has_many :team_members, foreign_key: "team_id"

  validates :name, presence: true
  validates :description, presence: true
  validates :team_email, presence: true
end
