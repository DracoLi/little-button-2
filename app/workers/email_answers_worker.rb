class EmailsAnswersWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    # Get some answers to be sent out
    # TODO: Priotize answers with nil last_emailed_time
    ques_count = (company.questions.count * 0.5).to_i
    questions = company.questions.order('answers_count DESC').limit(ques_count).all
    question = Question.where("id in (?)", questions.map(&:id)).order('last_emailed_time ASC').first

    if question.answers.count > 0
      # Send the answers to people in the company
      GeneralMailer.send_answers_to_question(company, question)

      # Update last emailed time
      question.last_emailed_time = Time.zone.now
      question.save
    end

    # Schedule the next question collection
    next_diff = company.email_answers_schedule.next_scheduled_time_diff(company.timezone)
    EmailsAnswersWorker.perform_in(next_diff, company_id)
  end
end
