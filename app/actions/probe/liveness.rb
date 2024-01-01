# frozen_string_literal: true

module Stellar
  module Actions
    module Probe
      class Liveness < Stellar::Action
        def handle(_req, res)
          res.body = JSON.dump({ status: 'ok' })
        end
      end
    end
  end
end
