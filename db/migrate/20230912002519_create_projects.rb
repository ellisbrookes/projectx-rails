class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.date :estimated_completion_date
      t.date :completion_date

      t.timestamps
    end
  end
end
