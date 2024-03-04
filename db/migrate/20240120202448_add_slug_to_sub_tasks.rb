class AddSlugToSubTasks < ActiveRecord::Migration[7.1]
  def change
    add_column(:sub_tasks, :slug, :string)
    add_index(:sub_tasks, :slug, unique: true)
  end
end
