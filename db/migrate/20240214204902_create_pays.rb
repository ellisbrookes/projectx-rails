class CreatePays < ActiveRecord::Migration[7.1]
  def change
    create_table :pays do |t|
      t.string :User

      t.timestamps
    end
  end
end
