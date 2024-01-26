class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.integer :quantity
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
