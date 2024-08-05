# frozen_string_literal: true

source 'https://rubygems.org'

ruby '~> 3.2.3'

gem 'hanami', '~> 2.1'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-lambda', github: 'elct9620/hanami-lambda', branch: 'main'
gem 'hanami-router', '~> 2.1'
gem 'hanami-validations', '~> 2.0'

gem 'dry-configurable', '~> 1.0'
gem 'dry-types', '~> 1.0'

gem 'google-apis-sheets_v4', '~> 0.33.0'
gem 'googleauth'

gem 'ruby-openai'
gem 'telegram-bot-ruby'

gem 'async-http'
gem 'feedjira'

gem 'faraday', '~> 2.10.1'

group :cli, :development, :test do
  gem 'dotenv'
  gem 'puma'
  gem 'rake'
  gem 'rubocop'

  gem 'hanami-cucumber'
  gem 'hanami-rspec'
end

group :development do
  gem 'guard-puma', '~> 0.8'
  gem 'ruby-lsp'

  gem 'hanami-reloader'
end

group :test do
  gem 'rack-test'

  gem 'capybara'
  gem 'selenium-webdriver'
end
