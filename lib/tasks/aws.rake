# frozen_string_literal: true

namespace :aws do
  desc 'Dump secrets from AWS Secrets Manager'
  task secrets: :environment do
    settings = Hanami.app[:settings]
    name = settings.secret.name

    sh "aws secretsmanager get-secret-value --secret-id #{name} > config/secrets/#{name}.json"
  end
end
