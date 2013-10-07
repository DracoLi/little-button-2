class Company < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :answers, through: :questions

  has_one :scheduled_collect_answer, dependent: :destroy
  has_one :scheduled_collect_question, dependent: :destroy
  has_one :scheduled_email_answers, dependent: :destroy

  def next_collect_answer_email_time(question)

  end

  def next_collect_question_time

  end

  def next_email_answers_time

  end
end
