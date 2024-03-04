class RemoveDescriptionFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column(:items, :description, :string)
  end
end
