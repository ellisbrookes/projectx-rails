class Company < ApplicationRecord
  has_many :users
  has_many :teams, dependent: :destroy
  has_many :projects

  validates :name, presence: true
  validates :description, presence: true
  validates :email, presence: true

  def add_user(user)
    users << user unless users.include?(user)
  end

  def remove_user(user)
    users.delete(user)
  end
end
