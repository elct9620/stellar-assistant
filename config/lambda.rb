# frozen_string_literal: true

module Stellar
  class Lambda < Hanami::Lambda::Dispatcher
    delegate 'StellarDailyJob', to: 'daily'
  end
end
