# frozen_string_literal: true

module Stellar
  module Functions
    class Daily < Stellar::Function
      type Events::EventBridge

      include Deps['repositories.news_feeds']

      def handle(event, _context)
        past1day = event.time - (60 * 60 * 24)
        feeds = news_feeds.where(newer_than: past1day)

        { count: feeds.size }
      end
    end
  end
end
