# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scheduled_time do
    frequency "MyString"
    day "MyString"
    time "2013-10-06 18:02:49"
  end
end
