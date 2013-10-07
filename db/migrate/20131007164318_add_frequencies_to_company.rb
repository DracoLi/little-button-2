class AddFrequenciesToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :collect_answers_schedule_id, :integer
    add_column :companies, :collect_questions_schedule_id, :integer
    add_column :companies, :email_answers_schedule_id, :integer
    add_column :companies, :email_answers_schedule_id, :integer

    add_column :companies, :timezone, :string
  end
end
