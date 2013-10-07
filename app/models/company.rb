class Company < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :answers, through: :questions

  has_one :collect_answers_schedule,
          class_name: 'ScheduledTime',
          foreign_key: 'collect_answers_schedule_id'
  has_one :collect_questions_schedule,
          class_name: 'ScheduledTime',
          foreign_key: 'email_questions_schedule_id'
  has_one :email_answers_schedule,
          class_name: 'ScheduledTime',
          foreign_key: 'email_answers_schedule_id'
end
