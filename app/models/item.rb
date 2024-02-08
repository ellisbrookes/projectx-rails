class Item < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
end
