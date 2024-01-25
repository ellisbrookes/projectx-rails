class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.string :client_name
      t.date :issue_date
      t.date :due_date
      t.decimal :amount
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
