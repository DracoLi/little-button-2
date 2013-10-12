# == Schema Information
#
# Table name: answers
#
#  id                :integer          not null, primary key
#  content           :string(255)
#  user_id           :integer
#  question_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#  last_emailed_time :datetime
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, counter_cache: true

  validate :only_one_answer_per_user_per_question

  private
    def only_one_answer_per_user_per_question
      if question.answers.where(user: user).count > 1
        errors.add(:question, "Cannot provide multiple answers for a question.")
      end
    end
end
