# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "Loose Bros ##{n}" }
  end
end