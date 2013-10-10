# == Schema Information
#
# Table name: scheduled_times
#
#  id                            :integer          not null, primary key
#  frequency                     :string(255)
#  day                           :string(255)
#  time                          :datetime
#  created_at                    :datetime
#  updated_at                    :datetime
#  collect_answers_schedule_id   :integer
#  collect_questions_schedule_id :integer
#  email_answers_schedule_id     :integer
#

class ScheduledTime < ActiveRecord::Base

  belongs_to :company, inverse_of: :collect_answers_schedule
  belongs_to :company, inverse_of: :collect_questions_schedule
  belongs_to :company, inverse_of: :email_answers_schedule

  def next_scheduled_time(timezone)

    next_time = nil

    Time.use_zone(timezone) do
      now = Time.zone.now

      if self.frequency == 'daily'

        next_time = Time.zone.local(now.year, now.month, now.day, self.time.hour, self.time.min)
        if next_time <= now
          next_time = next_time + 1.day
        end

      elsif self.frequency == 'weekly'

        next_time = Time.zone.local(now.year, now.month, now.day, self.time.hour, self.time.min)

        # Handle next is next week
        if next_time.wday > self.day || \
           (next_time.wday == self.day && next_time < now)
          next_time = next_time + 7.days
        end

        # Adjust time so we are on the right day of the week
        next_time = next_time + (self.day - now.wday).days

      elsif self.frequency == 'monthly'

        next_time = Time.zone.local(now.year, now.month, self.day, self.time.hour, self.time.min)
        if next_time <= now
          next_time = next_time + 1.month
        end
      end

    end

    next_time
  end

  def to_s
    "Schedule: #{self.frequency}, day (#{self.day}), #{self.time.strftime("%I:%M %p")}"
  end
end
