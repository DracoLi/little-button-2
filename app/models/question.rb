class Question < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  has_many :answers

  def answered_p
    self.company.users.count / self.answers.count.to_f
  end

  def lastest_answer
    self.answers.order('created_at DESC').first
  end

  def answered(user)
    !self.answer_for_user(user).nil?
  end

  def answer_for_user(user)
    self.answers.where(user: user).first
  end

  # Data related to this question, including its content and answer rate
  def question_data
    {
      id: self.id,
      content: self.content,
      user: self.user.id,
      added_source: self.added_source,
      company: self.company.id,
      answered_p: self.answered_p,

      # TODO: Need to humanize these times
      # TODO: use scope to get the lastest easily
      lastest_answered_h: self.lastest_answer.created_at.to_formatted_s(:time),
      added_h: self.created_at.to_formatted_s(:time)
    }
  end

  def question_data_for_user(user)
    self.question_data.merge({
      answered: self.answered(user)
    })
  end
end
