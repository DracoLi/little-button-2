# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

company = Company.create(name: 'Loose Button')
user = FactoryGirl.create(:user, company: company)
ques = Question.create(content: 'I like cheese, do you like them as well?', user: user, added_source: 'web', company: company)
ques2 = Question.create(content: 'I had a baby once, did you have one?', user: user, added_source: 'web', company: company)

FactoryGirl.create_list(:answer, 5, question: ques2, user: user)
user2 = FactoryGirl.create(:user, company: company, email: "dli@loosebutton.com")
FactoryGirl.create(:answer, question: ques, user: user2)
