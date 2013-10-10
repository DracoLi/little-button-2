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

end
