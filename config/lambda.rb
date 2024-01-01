# frozen_string_literal: true

require 'hanami/setup'
require 'hanami/lambda'

module Stellar
  class Lambda < Hanami::Lambda::Application
    register 'StellarApiHandler'
  end
end
