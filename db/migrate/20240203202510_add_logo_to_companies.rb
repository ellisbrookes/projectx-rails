class AddLogoToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :logo, :blob
  end
end
