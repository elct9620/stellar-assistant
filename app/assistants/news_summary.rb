# frozen_string_literal: true

module Stellar
  module Assistants
    class NewsSummary
      include Deps[
        'openai',
        'settings'
      ]

      CF_AIG_HEADER = 'cf-aig-metadata'
      PROMPT_VERSION = '2024-07-22'
      PROMPTS = [
        {
          role: 'system',
          content: <<~PROMPT
            你是一個專業的新聞分析師，請從自由時報、中央社等台灣主要新聞來源中挑選出今天最具價值的新聞。

            * **優先考慮:** 台灣相關的政治和經濟新聞。
            * **政治:** 包含選舉、政黨內部鬥爭、外交政策等。
            * **經濟:** 包含股市走勢、產業發展、通膨率等。
            * **"最有價值" 的定義:**  對台灣未來發展影響最大的新聞。

            請以一句話描述新聞新聞標及，並附上連結。摘要應使用自己的話語進行敘述，無法知道細節請不要猜測，確保原文不被曲解。

            請以以下 JSON 格式輸出結果：

            {
              "summaries": [
                "<摘要> - <連結>"
              ],
              "steps": [
                "推薦原因一",
                "推薦原因二",
              ]
            }

            請使用正體中文和台灣用語。
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
        openai.add_headers(CF_AIG_HEADER => JSON.dump(prompt_version: PROMPT_VERSION))
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
