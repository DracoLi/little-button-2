class EmailsAnswersWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    # Get some answers to be sent out
    question = company.questions.order('last_emailed_time DESC').first

    # Send the answers to people in the company
    GeneralMailer.send_answers_to_question(company, question)

    # Schedule the next question collection
    next_time = company.email_answers_schedule.next_scheduled_time(company.timezone)
    EmailsAnswersWorker.perform_in(next_time, company)
  end
end
