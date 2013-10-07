class CollectQuestionsWorker
  include Sidekiq::Worker

  def perform(company)
    # Email everyone in this company for new questions
    GeneralMailer.ask_for_questions(company)

    # Schedule the next question collection
    CollectQuestionsWorker.perform_in(, company)
  end
end
