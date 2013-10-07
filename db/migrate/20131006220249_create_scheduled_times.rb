class CreateScheduledTimes < ActiveRecord::Migration
  def change
    create_table :scheduled_times do |t|
      t.string :frequency
      t.string :day
      t.datetime :time

      t.timestamps
    end
  end
end
