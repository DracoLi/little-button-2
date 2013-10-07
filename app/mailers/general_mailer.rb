 class GeneralMailer < MandrillMailer::TemplateMailer
  default from: 'crazybot@littlebutton.co',
          from_name: "Crazy Bot"

  def ask_for_questions(company)
    vars = {'FROM_NAME' => 'Crazy Bot'}
    recipients = company.users
    mandrill_mail template: 'add-lilbutton-question',
      subject: "It's time to ask your buddies at #{company.name} a question!",
      to: recipients.map {|user| { email: user.email, name: user.name }},
      vars: vars,
      recipient_vars: recipients.map {|user| { user.email => { "NAME" => user.name }}}
  end

  def ask_for_answers(company, questions_data)
    questions_data.each do |ques_id, users|
      question = Question.find(ques_id)
      recipients = users
      vars = {
        'FROM_NAME' => 'Crazy Bot',
        'QUESTION' => question.content
      }
      mandrill_mail template: 'add-lilbutton-answer',
        subject: question.content,
        to: recipients.map {|user| { email: user.email, name: user.name }},
        vars: vars,
        recipient_vars: recipients.map {|user| { user.email => { "NAME" => user.name }}}
    end
  end

  def send_answers_to_question(company, question)
    answers_content = ""
    question.answers.each do |answer|
      answers_content += "<p><b>#{answer.user.name}:</b> #{answer.content}</p>"
    end
    vars = {
      'FROM_NAME' => 'Crazy Bot',
      'QUESTION' => question.content
    }
    recipients = company.users
    mandrill_mail template: 'send-lilbutton-answers',
      subject: "#{company.name} Team Answers: #{question.content}",
      to: recipients.map {|user| { email: user.email, name: user.name }},
      vars: vars
  end

 end
