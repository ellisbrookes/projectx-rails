class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.references :company, foreign_key: { on_delete: :cascade }
      t.string :name
      t.text :description
      t.string :team_email

      t.timestamps
    end
  end
end
