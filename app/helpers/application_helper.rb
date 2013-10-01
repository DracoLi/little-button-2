module ApplicationHelper

  def company_answers
    current_user.company.answers
  end

  def company_questions
    current_user.company.questions
  end

end
