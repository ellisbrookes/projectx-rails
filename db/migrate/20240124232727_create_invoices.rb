class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table(:invoices) do |t|
      t.string(:invoice_issue)
      t.string(:customer)
      t.string(:customer_address)
      t.string(:company_address)
      t.string(:notes)
      t.date(:issue_date)
      t.date(:due_date)
      t.decimal(:amount)
      t.references(:company, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
