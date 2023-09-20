class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.date :start_date
      t.date :completion_date
      t.string :assigned_to
      t.string :status

      t.timestamps
    end
  end
end
