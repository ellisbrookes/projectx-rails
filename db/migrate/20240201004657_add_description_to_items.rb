class AddDescriptionToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :description, :string
  end
end
