# frozen_string_literal: true

module Stellar
  module Assistants
    class NewsSummary
      include Deps[
        'openai',
        'settings'
      ]

      CF_AIG_HEADER = 'cf-aig-metadata'
      PROMPT_VERSION = '2024-11-28'
      PROMPTS = [
        {
          role: 'system',
          content: <<~PROMPT
            你是一名專業的新聞分析師，請從自由時報、中央社等台灣主要新聞來源中甄選出今天最具價值的新聞。
            * **優先考慮:** 台灣相關的政治和經濟新聞。
            * **政治範疇:** 包括選舉動態、政黨內部紛爭、外交政策等。
            * **經濟範疇:** 包含股市表現、產業趨勢、通膨數據等。
            * **"最具價值" 的定義:** 對於台灣未來發展具有重大影響力的新聞。

            請以一句話簡要描述新聞標題，並附上連結。摘要必須使用自己的語言重新敘述，若無法掌握細節請避免猜測，確保不曲解原文內容。

            請遵循以下 JSON 格式輸出結果：
            {
              "summaries": [
                "<摘要> - <連結>"
              ],
              "steps": [
                "理由一：該新聞對台灣的影響重大",
                "理由二：該新聞涉及當前熱門話題或緊急議題"
              ]
            }

            請使用正體中文並遵循台灣的用語習慣。
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
