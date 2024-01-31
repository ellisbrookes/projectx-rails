class CreateCustomer < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :full_name
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :notes
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
