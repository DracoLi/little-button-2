class CompaniesController < ApplicationController

  def company_from_email
    email = params[:email]
    domain = email.split("@").last
    companies = Company.where(email_domain: domain)
    if companies.exists?
      render json: { name: companies.first.name }
    else
      render json: { error: 'No matching company' }, status: 404
    end
  end

  def little_button_chrome
    count = params[:count]
    answers = Answer.order("RANDOM()").limit(count)
    answers.map do |answer|
      if answer.user
        answer.content = "(#{answer.user.name}) #{answer.question.content} #{answer.content}"
      else
        answer.content = "#{answer.question.content} #{answer.content}"
      end
    end
    render json: answers
  end

end
