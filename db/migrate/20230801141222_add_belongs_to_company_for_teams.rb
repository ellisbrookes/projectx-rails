class AddBelongsToCompanyForTeams < ActiveRecord::Migration[7.0]
  def change
    add_reference(:teams, :company, foreign_key: true)
  end
end
