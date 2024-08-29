class Item < ApplicationRecord
  belongs_to :company
  has_many :invoice_items

  has_rich_text :description

  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true

  def total_price
    unit_price * quantity
  end
end
