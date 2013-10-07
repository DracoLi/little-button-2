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

  def ask_for_answers(question)
    vars = {
      'FROM_NAME' => 'Crazy Bot',
      'QUESTION' => question.content
    }
    recipients = question.company.users
    mandrill_mail template: 'add-lilbutton-answer',
      subject: question.content,
      to: recipients.map {|user| { email: user.email, name: user.name }},
      vars: vars,
      recipient_vars: recipients.map {|user| { user.email => { "NAME" => user.name }}}
  end

  def send_some_answers

  end

 end
