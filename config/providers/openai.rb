# frozen_string_literal: true

Hanami.app.register_provider :openai do
  prepare do
    require 'openai'
  end

  start do
    secret = target[:secret]
    access_token = secret.get(:OPENAI_ACCESS_TOKEN)
    uri_base = secret.get(:OPENAI_URI_BASE)

    client = OpenAI::Client.new(access_token:, uri_base:)

    register(:openai, client)
  end
end
