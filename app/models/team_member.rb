class TeamMember < ApplicationRecord
  has_many :team
  belongs_to :user
end
