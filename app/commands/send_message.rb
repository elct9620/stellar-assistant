# frozen_string_literal: true

module Stellar
  module Commands
    class SendMessage
      include Deps[
        'settings',
        'telegram'
      ]

      def call(message)
        telegram.api.send_message(
          chat_id: settings.telegram_chat_id,
          text: message
        )
      end
    end
  end
end
