class RemoveTeamEmailFromTeams < ActiveRecord::Migration[7.1]
  def change
    remove_column :teams, :team_email, :string
  end
end
