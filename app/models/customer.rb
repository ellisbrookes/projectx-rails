class Customer < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || full_name_changed?
  end

  belongs_to :company
  has_many :invoices

  validates :full_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :notes, presence: true
end
