class AddLastEmailedTimeToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :last_emailed_time, :datetime
  end
end
