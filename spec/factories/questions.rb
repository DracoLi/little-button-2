# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    sequence(:content) { |n| "Do you have #{n} kids that have some time of weapons in their apartment?" }
    company
  end
end
