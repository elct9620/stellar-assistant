# frozen_string_literal: true

module Stellar
  module Assistants
    class NewsSummary
      include Deps[
        'openai',
        'settings'
      ]

      PROMPTS = [
        {
          role: 'system',
          content: <<~PROMPT
            You are a professional analyst in the company. You are asked to pick the most valuable news today.
            Constraints:
            * The Taiwan-related news is prioritized.
            * The political and economic news is prioritized.
            * The summary should be 3-5 sentences long.
            * The summary should be in your own words.
            * The summary should be accurate and should not include any false information.
            * The summary format is "<summary> - <link>".
            * Don't mix different news together.

            Please always respond in Taiwanese Mandarin with Taiwan terms.
            When mixing English and Taiwanese Mandarin, add a space between them.

            Give the summary in the JSON "summaries" key path.
            Give the reasons use Chinese in the JSON "steps" key.
            Both keys are required.
          PROMPT
        }
      ].freeze

      def call(feeds)
        reply = completion([
                             PROMPTS[0],
                             { role: 'user', content: JSON.dump(feeds) }
                           ])
        content = reply.fetch('content', '')
        JSON.parse(content)
      end

      private

      def completion(messages)
        openai.chat(
          parameters: {
            model: settings.openai.model,
            temperature: settings.openai.temperature,
            messages:
          }
        ).dig('choices', 0, 'message')
      end
    end
  end
end
