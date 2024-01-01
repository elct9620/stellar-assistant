# frozen_string_literal: true

source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-lambda', github: 'elct9620/hanami-lambda', branch: 'main'
gem 'hanami-router', '~> 2.0'
gem 'hanami-validations', '~> 2.0'

gem 'dry-types', '~> 1.0', '>= 1.6.1'
gem 'puma'
gem 'rake'

group :development, :test do
  gem 'dotenv'
  gem 'rubocop'

  gem 'hanami-rspec'
end

group :development do
  gem 'guard-puma', '~> 0.8'
  gem 'ruby-lsp'

  gem 'hanami-reloader'
end

group :test do
  gem 'rack-test'
end
