# frozen_string_literal: true

Hanami.app.register_provider :telegram do
  prepare do
    require 'telegram/bot'
  end

  start do
    secret = target[:secret]
    token = secret.get(:TELEGRAM_BOT_TOKEN)

    client = Telegram::Bot::Client.new(token)

    register(:telegram, client)
  end
end
