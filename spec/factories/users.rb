# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Draco Li"
    sequence(:email) { |n| "example#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end
