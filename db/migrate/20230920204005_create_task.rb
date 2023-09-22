class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.date :due_date
      t.integer :assigned_to
      t.integer :project_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
