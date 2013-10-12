class AddFrequenciesToCompany < ActiveRecord::Migration
  def change
    add_column :scheduled_times, :collect_answers_schedule_id, :integer
    add_column :scheduled_times, :collect_questions_schedule_id, :integer
    add_column :scheduled_times, :email_answers_schedule_id, :integer

    add_column :companies, :timezone, :string, default: 'UTC'
  end
end
