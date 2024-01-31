class Customer < ApplicationRecord
  belongs_to :company

  validates :full_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :notes, presence: true
end
