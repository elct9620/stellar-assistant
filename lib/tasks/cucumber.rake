# frozen_string_literal: true

require 'cucumber/rake/task'

namespace :cucumber do
  Cucumber::Rake::Task.new(:lambda, 'Run features that trigger by AWS Lambda') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'lambda'
  end
end

task default: 'cucumber:lambda'
