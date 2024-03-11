# app/models/invoice.rb
class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  has_many :invoice_items

  accepts_nested_attributes_for :invoice_items

  validates :invoice_issue, presence: true
  validates :customer_id, presence: true
  validates :customer_address, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true
  validates :company_address, presence: true
  validates :amount, presence: true

  def calculate_total_amount
    self.total_amount = items.sum(&:total_price)
  end
end
