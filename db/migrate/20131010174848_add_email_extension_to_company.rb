class AddEmailExtensionToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :email_domain, :string
  end
end
