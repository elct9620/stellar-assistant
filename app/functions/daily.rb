# frozen_string_literal: true

module Stellar
  module Functions
    class Daily < Stellar::Function
      type Events::EventBridge

      def handle(event, context); end
    end
  end
end
