class AddClientAddressToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :client_address, :string
  end
end
