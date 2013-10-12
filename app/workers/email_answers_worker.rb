class EmailAnswersWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    # Schedule the next question collection
    next_diff = company.email_answers_schedule.next_scheduled_time_diff
    EmailAnswersWorker.perform_in(next_diff, company_id)

    # Get some most answered questions
    ques_count = (company.questions.count * 0.5).to_i
    questions = company.questions.order('answers_count DESC').limit(ques_count).all

    # Sort this questions by last emailed time.
    # If null, then just take a question with null time
    questions = Question.where("id in (?)", questions.map(&:id))
    nullques = questions.where('last_emailed_time IS NULL')
    if nullques.exists?
      question = nullques.first
    else
      question = questions.order('last_emailed_time ASC').first
    end

    # Email the users if our targeted question has answer.
    #
    # Notes:
    # If it does not have answers then we just skip this scheduled send.
    # This is not optimal but since this does not happen as long as there are
    # some data so I did not try to think of a better solution.
    if question.answers.count > 0
      # Send the answers to people in the company
      GeneralMailer.send_answers_to_question(company, question)

      # Update last emailed time
      question.last_emailed_time = Time.zone.now
      question.save
    end
  end
end
