class CollectAnswersWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    # Schedule the next question collection
    next_diff = company.collect_answers_schedule.next_scheduled_time_diff
    CollectAnswersWorker.perform_in(next_diff, company_id)

    # Get an array of questions and users to asks for that question
    # Priotize collecting answers for questions that we have not emailed yet.
    all_questions = {}
    questions = company.questions.where('last_emailed_time IS NULL').all
    questions = questions + company.questions\
                                   .where('last_emailed_time IS NOT NULL')\
                                   .order('last_emailed_time ASC')
    company.users.each do |user|
      questions.each do |ques|
        # Find an unanswered question for this user
        if !user.answered?(ques)
          if !all_questions.has_key?(ques.id)
            all_questions[ques.id] = []
          end
          all_questions[ques.id] << user
          break
        end
      end
    end

    # Email everyone in this company to get some answers
    if all_questions.count > 0
      GeneralMailer.ask_for_answers(company, all_questions)
    end
  end
end
