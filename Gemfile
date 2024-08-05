source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem 'active_model_serializers'
gem "bootsnap", require: false
gem 'capybara'
gem 'dotenv', '~> 2.1', '>= 2.1.1'
gem 'faraday'
gem 'faraday-cookie_jar'
gem 'jwt'
gem 'mechanize'
gem "pg", "~> 1.1"
gem 'pry'
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem 'redis'
gem 'selenium-webdriver'
gem 'sidekiq', '~> 6.0'
gem 'sidekiq-status'
gem 'throttle'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]


group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rspec-rails'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers', '~> 6.0'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem "web-console"
end
