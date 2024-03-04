class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table(:items) do |t|
      t.references(:company, null: false, foreign_key: true)
      t.integer(:quantity)

      t.timestamps
    end
  end
end
