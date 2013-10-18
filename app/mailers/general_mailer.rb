 class GeneralMailer < MandrillMailer::TemplateMailer
  default from: 'bot@littlebutton.dracoli.com',
          from_name: "Draco Bot"

  def welcome_message(user)
    company = user.company
    vars = {
      'USER_NAME' => user.name,
      'SERVICE_NAME' => "Little Button for #{company.name}",
      'FROM_NAME' => user.company.botname,
      'COLLECT_ANSWER' => company.collect_answers_schedule.to_s,
      'COLLECT_QUESTION' => company.collect_questions_schedule.to_s,
      'EMAIL_ANSWERS' => company.email_answers_schedule.to_s
    }
    mandrill_mail template: 'welcome-user',
      subject: "Welcome to Little Button for #{company.name}",
      to: { email: user.email, name: user.name },
      from_name: company.botname,
      vars: vars
  end

  def ask_for_questions(company)
    vars = {'FROM_NAME' => company.botname}
    company.users.each do |user|
      mail = mandrill_mail template: 'add-lilbutton-question',
        subject: "Ask your team at #{company.name} a question",
        to: { email: user.email, name: user.name },
        from_name: company.botname,
        vars: vars
      mail.deliver
    end

  end

  def ask_for_answers(company, questions_data)
    questions_data.each do |ques_id, users|
      question = Question.find(ques_id)
      recipients = users
      vars = {
        'FROM_NAME' => company.botname,
        'QUESTION' => question.content
      }
      recipients.each do |user|
        mail = mandrill_mail template: 'add-lilbutton-answer',
          subject: '|Answer Needed| ' + question.content,
          to: { email: user.email, name: user.name },
          from_name: company.botname,
          vars: vars
        mail.deliver
      end
    end
  end

  def send_answers_to_question(company, question)
    answers_content = ""
    question.answers.each do |answer|
      answers_content += "<p><b>#{answer.user.name}:</b> #{answer.content}</p>"
    end
    vars = {
      'FROM_NAME' => company.botname,
      'QUESTION' => question.content,
      'ANSWERS' => answers_content
    }
    company.users.each do |user|
      mail = mandrill_mail template: 'send-lilbutton-answers',
        subject: "Team #{company.name} answers: #{question.content}",
        to: { email: user.email, name: user.name },
        from_name: company.botname,
        vars: vars
      mail.deliver
    end
  end

 end
