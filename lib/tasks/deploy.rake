# frozen_string_literal: true

desc 'Run SAM build'
task :build do
  sh 'sam build --use-container --cached'
end

desc 'Deploy to AWS'
task deploy: :build do
  sh 'sam deploy'
end
