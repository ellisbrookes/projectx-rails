class AddCompanyIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :company_id, :integer
  end
end
