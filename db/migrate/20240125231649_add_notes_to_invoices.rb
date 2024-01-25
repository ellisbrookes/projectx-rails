class AddNotesToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :notes, :string
  end
end
