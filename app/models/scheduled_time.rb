class ScheduledTime < ActiveRecord::Base

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

end
