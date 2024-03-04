# app/models/invoice.rb
class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer

  has_many :items

  validates :invoice_issue, presence: true
  validates :customer_id, presence: true
  validates :customer_address, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true
  validates :company_address, presence: true
  validates :amount, presence: true

  accepts_nested_attributes_for :items

  def items_attributes=(item_attributes)
    item_attributes.values.each do |item_attribute|
      item = Item.find_or_create_by(item_attribute)
      items << item
    end
  end
end
