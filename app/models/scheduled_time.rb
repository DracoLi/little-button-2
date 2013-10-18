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

  belongs_to :collect_answers_schedule, class_name: 'Company'
  belongs_to :collect_questions_schedule, class_name: 'Company'
  belongs_to :email_answers_schedule, class_name: 'Company'

  def company
    if self.collect_answers_schedule
      self.collect_answers_schedule
    elsif self.collect_questions_schedule
      self.collect_questions_schedule
    elsif self.email_answers_schedule
      self.email_answers_schedule
    end
  end

  def wday
    day = self.day
    if day == 'Monday'
      1
    elsif day == 'Tuesday'
      2
    elsif day == 'Wednesday'
      3
    elsif day == 'Thursday'
      4
    elsif day == 'Friday'
      5
    elsif day == 'Saturday'
      6
    elsif day == 'Sunday'
      7
    end
  end

  def next_scheduled_time_diff
    timezone = self.company.timezone
    next_time = self.next_scheduled_time.in_time_zone(timezone)
    next_time - ActiveSupport::TimeZone[timezone].now
  end

  def next_scheduled_time
    next_time = nil
    timezone = self.company.timezone
    time = self.time.utc
    Time.use_zone(timezone) do
      now = Time.zone.now

      if self.frequency == 'Daily'

        next_time = Time.zone.local(now.year, now.month, now.day, time.hour, time.min)
        if next_time <= now
          next_time = next_time + 1.day
        end

      elsif self.frequency == 'Weekly'

        next_time = Time.zone.local(now.year, now.month, now.day, time.hour, time.min)

        # Handle next is next week
        if next_time.wday > self.wday || \
           (next_time.wday == self.wday && next_time < now)
          next_time = next_time + 7.days
        end

        # Adjust time so we are on the right day of the week
        next_time = next_time + (self.wday - now.wday).days

      elsif self.frequency == 'Monthly'

        next_time = Time.zone.local(now.year, now.month, self.day, time.hour, time.min)
        if next_time <= now
          next_time = next_time + 1.month
        end
      end

    end

    next_time
  end

  def to_s
    next_time = self.next_scheduled_time
    time_of_day = next_time.strftime("%l:%M%P").strip + " #{next_time.zone}"
    if self.frequency == 'Daily'
      "#{self.frequency} at #{time_of_day}"
    elsif self.frequency == 'Weekly'
      "#{self.frequency}, every #{self.day} at #{time_of_day}"
    elsif self.frequency = 'Monthly'
      "#{self.frequency} on day #{self.day} at #{time_of_day}"
    end
  end
end
