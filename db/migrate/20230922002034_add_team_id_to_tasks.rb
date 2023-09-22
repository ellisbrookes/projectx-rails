class AddTeamIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :team_id, :integer
  end
end
