class AddPrimaryCompanyBusinessToUser < ActiveRecord::Migration
  def change
    add_column :users, :primary_company_business_id, :integer
  end
end
