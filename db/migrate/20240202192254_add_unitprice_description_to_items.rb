class AddUnitpriceDescriptionToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :unit_price, :decimal
    add_column :items, :description, :string
  end
end