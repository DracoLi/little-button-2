class CollectQuestionsWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    # Email everyone in this company for new questions
    GeneralMailer.ask_for_questions(company)

    # Schedule the next question collection
    next_time = company.collect_questions_schedule.next_scheduled_time(company.timezone)
    CollectQuestionsWorker.perform_in(next_time, company)
  end
end
