# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/lambda'

module Stellar
  class Lambda < Hanami::Lambda::Application
    delegate 'StellarDailyJob', to: 'daily'

    environment :production do
      require 'secrets'

      Secrets.config.provider = Secrets::Aws
    end
  end
end
