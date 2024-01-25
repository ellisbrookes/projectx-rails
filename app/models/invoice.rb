# app/models/invoice.rb
class Invoice < ApplicationRecord
  belongs_to :project
  validates :invoice_number, presence: true
  validates :client_name, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true
  validates :client_address, presence: true
  validates :company_address, presence: true
  validates :notes, presence: true
  validates :amount, presence: true
end
