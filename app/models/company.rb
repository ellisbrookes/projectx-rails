class Company < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  has_one_attached :logo
  has_many :users
  has_many :teams, dependent: :destroy
  has_many :projects
  has_many :invoices
  has_many :customers

  validates :name, presence: true
  validates :description, presence: true
  validates :billing_email, presence: true
  validates :contact_email, presence: true
  validates :address, presence: true
end
