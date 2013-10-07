class EmailProcessor
  def self.process(email)
    from_email = email.from[0][:email]
    user = User.find(email: from_email)

    # Take only the first line
    content = email.body.lines.first.strip

    # Add a new question
    if email.subject.include? "ask your buddies"
      Question.where({
        company: user.company,
        content: content
      }).first_or_create(user: user, added_source: 'email')
    end

    # Add a new answer to question
    if email.raw_text.include? 'provide your answer to the following question'
      question = user.company.questions.where(content: email.subject)
      if question.length > 0
        question.answers.create(content: content, user: user)
      end
    end

  end
end
