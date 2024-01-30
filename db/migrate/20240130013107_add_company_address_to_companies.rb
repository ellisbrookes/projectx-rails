class AddCompanyAddressToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :address, :string
  end
end
