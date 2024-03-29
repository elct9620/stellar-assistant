# frozen_string_literal: true

desc 'Run SAM build'
task :build, %i[function_name] => :environment do |_, args|
  sh "sam build --parallel --use-container --cached #{args.function_name}"
end

desc 'Invoke Lambda locally'
task :invoke, %i[function_name event] => :environment do |_, args|
  envfile = Hanami.app.root.join('env.json')
  command = "sam local invoke #{args.function_name} -e spec/fixtures/events/#{args.event || 'default'}.json"
  command += " --env-vars #{envfile}" if envfile.exist?
  sh command
end

desc 'Deploy to AWS'
task deploy: :build do
  sh 'sam deploy'
end
