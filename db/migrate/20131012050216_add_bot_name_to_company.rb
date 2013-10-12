class AddBotNameToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :botname, :string
  end
end
