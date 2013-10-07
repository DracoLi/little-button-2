class ScheduledTime < ActiveRecord::Base

  def next_scheduled_time(user)
    now = Time.now

    if self.frequency == 'daily'

    elsif self.frequency == 'weekly'

    elsif self.frequency == 'monthly'

    end
  end

end
