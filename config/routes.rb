# frozen_string_literal: true

module Stellar
  class Routes < Hanami::Routes
    root to: 'probe.liveness'
  end
end
