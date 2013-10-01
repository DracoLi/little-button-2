class Company < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :answers, through: :questions
end
