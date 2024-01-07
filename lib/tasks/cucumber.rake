# frozen_string_literal: true

namespace :cucumber do
  Cucumber::Rake::Task.new(:openai, 'Run features that call OpenAI') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'openai'
  end
end
