class RemoveRoleFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column(:users, :role, :integer)
  end
end
