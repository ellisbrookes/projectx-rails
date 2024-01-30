class AddCurrencyToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :currency, :string
  end
end
