# frozen_string_literal: true

Hanami.app.register_provider :secret do
  prepare do
    require 'secrets'
  end

  start do
    settings = target[:settings]
    provider = Secrets.build
    provider.token = ENV.fetch('AWS_SESSION_TOKEN', nil) if provider.is_a?(Secrets::Aws)

    secret = provider.get_secret(settings.secret.name)
    register(:secret, secret)
  end
end
