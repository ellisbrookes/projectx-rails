class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table(:tasks) do |t|
      t.string(:name)
      t.string(:description)
      t.string(:status)
      t.date(:due_date)
      t.references(:assigned_to)
      t.references(:project)
      t.references(:team)
      t.references(:reporter)

      t.timestamps
    end
  end
end
