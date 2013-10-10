# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  timezone   :string(255)
#

class Company < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :answers, through: :questions

  has_one :collect_answers_schedule,
          class_name: 'ScheduledTime',
          foreign_key: 'collect_answers_schedule_id',
          dependent: :destroy
  has_one :collect_questions_schedule,
          class_name: 'ScheduledTime',
          foreign_key: 'collect_questions_schedule_id',
          dependent: :destroy
  has_one :email_answers_schedule,
          class_name: 'ScheduledTime',
          foreign_key: 'email_answers_schedule_id',
          dependent: :destroy

  after_create :create_default_schedules

  private
    def create_default_schedules
      self.timezone = Time.zone.name if self.timezone.nil?
      self.create_collect_answers_schedule({
        frequency: 'Weekly',
        day: '3',
        time: ActiveSupport::TimeZone[self.timezone].parse('2000-01-01 9am')
      })
      self.create_collect_questions_schedule({
        frequency: 'Weekly',
        day: '2',
        time: ActiveSupport::TimeZone[self.timezone].parse('2000-01-01 9am')
      })
      self.create_email_answers_schedule({
        frequency: 'Weekly',
        day: '1',
        time: ActiveSupport::TimeZone[self.timezone].parse('2000-01-01 9am')
      })
      self.save
    end
end
