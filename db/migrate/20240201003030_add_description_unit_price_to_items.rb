class AddDescriptionUnitPriceToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :description, :string
    add_column :items, :unit_price, :string
  end
end
