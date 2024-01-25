class AddCompanyAddressToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :company_address, :string
  end
end
