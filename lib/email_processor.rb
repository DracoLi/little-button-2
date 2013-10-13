class EmailProcessor
  def self.process(email)
    from_email = email.from
    print "From Email: #{from_email}"
    user = User.where(email: from_email)
    if user.exists?
      user = user.first
    else
      return
    end

    # Take only the first line]
    content = email.body.lines.first.strip

    # Add a new question
    if email.subject.include? "Ask your team at"
      Question.where({
        company: user.company,
        content: content
      }).first_or_create(user: user, added_source: 'email')
    end

    # Add a new answer to question
    print "\nSubject: #{email.subject}\n"
    if email.subject.include? '|Answer Needed|'
      search = '|Answer Needed| '
      startpos = email.subject.index(search) + search.length
      ques_content = email.subject[startpos..-1]
      print "\nQues: #{ques_content}\n"
      question = user.company.questions.where(content: ques_content)
      if question.exists?
        question.first.answers.create(content: content, user: user)
      end
    end

  end
end
