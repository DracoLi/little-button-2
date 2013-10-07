class CollectAnswersWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    # Get an array of questions and users to asks for that question
    all_questions = {}
    questions = company.questions.order('last_emailed_time DESC')
    company.users.each do |user|
      questions.each do |ques|
        # Find an unanswered question for this user
        if !user.answered(ques)
          if !all_questions.has_key?(ques.id)
            all_questions[ques.id] = []
          end
          all_questions[ques.id] << user
          break
        end
      end
    end

    # Email everyone in this company to get some answers
    GeneralMailer.ask_for_answers(company, all_questions)

    # Schedule the next question collection
    next_time = company.collect_answers_schedule.next_scheduled_time(company.timezone)
    CollectAnswersWorker.perform_in(next_time, company)
  end
end
