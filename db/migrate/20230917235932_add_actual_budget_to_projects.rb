class AddActualBudgetToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column(:projects, :actual_budget, :decimal, precision: 10, scale: 2)
  end
end
