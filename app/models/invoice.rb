# app/models/invoice.rb
class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  has_many :items

  validates :invoice_issue, presence: true
  validates :customer, presence: true
  validates :customer_address, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true
  validates :company_address, presence: true
  validates :notes, presence: true
  validates :amount, presence: true
end
