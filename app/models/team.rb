# app/models/team.rb
class Team < ApplicationRecord
  belongs_to :company
  has_many :team_members, dependent: :destroy
  has_many :users, through: :team_members
  has_many :projects
  accepts_nested_attributes_for :team_members

  validates :name, presence: true
  validates :description, presence: true
  validates :email, presence: true

  def team_member_full_name
    if team_members&.first&.user&.present?
      team_members.first.user.full_name
    else
      "No team members or user data available"
    end
  end
end
