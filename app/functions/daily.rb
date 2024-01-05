# frozen_string_literal: true

module Stellar
  module Functions
    class Daily < Stellar::Function
      type Events::EventBridge

      def handle(_event, _context)
        { ok: true }
      end
    end
  end
end
