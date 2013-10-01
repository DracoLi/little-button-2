# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    sequence(:content) { |n| "I have #{n} disabled legs that can stretch across a whole freaking river!" }
    user
  end
end
