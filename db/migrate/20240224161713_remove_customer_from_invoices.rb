class RemoveCustomerFromInvoices < ActiveRecord::Migration[7.1]
  def change
    remove_column :invoices, :customer, :string
  end
end
