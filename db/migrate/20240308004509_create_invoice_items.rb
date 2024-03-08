class CreateInvoiceItems < ActiveRecord::Migration[7.1]
  def change
    create_table(:invoice_items) do |t|
      t.belongs_to(:invoice, null: false, foreign_key: true)
      t.belongs_to(:item, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
