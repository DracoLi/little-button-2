class CollectQuestionsWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    # Email everyone in this company for new questions
    GeneralMailer.ask_for_questions(company).deliver

    # Schedule the next question collection
    next_diff = company.collect_questions_schedule.next_scheduled_time_diff(company.timezone)
    CollectQuestionsWorker.perform_in(next_diff, company_id)
  end
end
