class AddLastEmailedTimeToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :last_emailed_time, :datetime
  end
end
