class AddCustomerIdToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column(:invoices, :belongs_to, :string)
    add_reference(:invoices, :customer, null: false, foreign_key: true)
  end
end
