# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  company_id             :integer
#  admin                  :boolean          default(FALSE)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :nullify

  validates_presence_of :name, :email
  validate :valid_company_email

  before_save :assign_company_from_email

  def answered?(question)
    question.answers.where(user: self).exists?
  end

  def answer_for_question(question)
    question.answers.where(user: self).first
  end

  def unanswered_questions
    Question.where(company: self.company).select do |ques|
      !self.answered?(ques)
    end
  end

  def answered_questions
    self.answers.map(&:question)
  end

  protected

    def valid_company_email
      domain = email.split("@").last
      unless Company.where(email_domain: domain).exists?
        errors.add(:email, 'Company not registered with Little Button')
      end
    end

    def assign_company_from_email
      if self.email && self.company.nil?
        domain = self.email.split("@").last
        self.company = Company.where(email_domain: domain).first
      end
    end
end
