class EmailProcessor
  def self.process(email)
    from_email = email.from.first[:email]
    print "From Email: #{from_email}"
    user = User.find(email: from_email)

    # Take only the first line
    content = email.body.lines.first.strip
    print "Content: #{content}"

    # Add a new question
    if email.subject.include? "Ask your team at"
      Question.where({
        company: user.company,
        content: content
      }).first_or_create(user: user, added_source: 'email')
    end

    # Add a new answer to question
    if email.subject.include? '|Answer Needed|'
      ques_content = email.subject.gsub(/\|Answer Needed\|\s/, '')
      question = user.company.questions.where(content: ques_content)
      if question.exists?
        question.first.answers.create(content: content, user: user)
      end
    end

  end
end
