source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Forms
gem 'simple_form', '~> 3.0.0.rc'

# Authentication
gem 'devise'
gem "cancan"

# Paignation
gem 'kaminari'

# API
gem 'grape'

# Email processing
gem 'mandrill_mailer'
gem 'griddler'

# Assets
gem 'sass-rails', '~> 4.0.0'
# gem "compass-rails", github: "milgner/compass-rails", ref: "1749c06f15dc4b058427e7969810457213647fb8" # To support rails 4
gem 'handlebars_assets'
gem 'flutie'
gem 'paloma' # Better page specific javascript

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Background jobs
gem 'sinatra', '>= 1.3.0', require: nil
gem 'sidekiq'
gem 'autoscaler'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# For hosting on heroku. Enables static asset serving and loggin
group :production do
  gem 'rails_12factor'
end

# Others
gem 'annotate'
gem 'figaro'
gem 'newrelic_rpm'
gem 'sentry-raven'

# Debugging
group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

# Testing
gem "rspec-rails", :group => [:development, :test]
gem "factory_girl_rails"
# gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false
group :test do
  # gem "launchy", ">= 2.1.2"
  gem "capybara"
  # gem "timecop", "~> 0.6.1"
  # gem "email_spec", ">= 1.4.0"
  gem "nyan-cat-formatter"
  gem 'fuubar'
end

# Console helpers
gem 'pry', :group => :development
gem 'pry-rails', :group => :development
gem 'quiet_assets', :group => :development
gem 'awesome_print'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
