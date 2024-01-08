# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/lambda'

module Stellar
  class App < Hanami::App
    extend Hanami::Lambda::Application

    config.actions.format :json
    environment :production do
      require 'secrets'

      Secrets.config.provider = Secrets::Aws
    end
  end
end
