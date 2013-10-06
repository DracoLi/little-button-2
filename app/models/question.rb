class Question < ActiveRecord::Base
  include ActionView::Helpers

  belongs_to :company
  belongs_to :user
  has_many :answers

  def answered_p
    self.company.users.count / self.answers.count.to_f
  end

  def latest_answer
    self.answers.order('created_at DESC').first
  end

  def latest_answered_h
    answer = self.latest_answer
    if answer
      time_ago_in_words answer.try(:created_at)
    else
      nil
    end
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
      latest_answered_h: latest_answered_h,
      added_h: time_ago_in_words(self.created_at)
    }
  end

  def question_data_for_user(user)
    self.question_data.merge({
      answered: self.answered(user)
    })
  end
end
