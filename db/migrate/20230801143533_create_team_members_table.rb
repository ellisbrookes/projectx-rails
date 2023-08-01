class CreateTeamMembersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :team_members do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.timestamps
    end
  end
end
