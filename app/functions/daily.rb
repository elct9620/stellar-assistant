# frozen_string_literal: true

module Stellar
  module Functions
    class Daily < Stellar::Function
      type Events::EventBridge

      include Deps[
        'repositories.news_feeds',
        'assistants.news_summary',
        'commands.send_message'
      ]

      def handle(event, _context)
        past1day = event.time - (60 * 60 * 24)
        feeds = news_feeds.where(newer_than: past1day)
        summary = news_summary.call(feeds)
        send_message.call(build_message(summary))
        summary
      end

      private

      def build_message(summary)
        <<~TEXT
          * #{summary['summaries'].join("\n* ")}

          #{summary['steps'].join("\n")}
        TEXT
      end
    end
  end
end
