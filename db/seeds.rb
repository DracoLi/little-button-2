# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

company = Company.create(name: 'Draken Solutions', email_domain: 'dracoli.com')
user = User.new({
  company: company,
  botname: 'Draco Bot',
  admin: true,
  timezone: 'Eastern Time (US & Canada)',
  name: 'Draco Li',
  email: 'draco@dracoli.com',
  password: 'password'
})
user.skip_confirmation!
user.save!
user.confirm!
