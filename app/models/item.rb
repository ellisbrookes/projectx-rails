class Item < ApplicationRecord
  belongs_to :company

  has_rich_text :description

  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
end
