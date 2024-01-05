# frozen_string_literal: true

if ENV['USE_LAMBDA']
  require 'hanami/cucumber/support/world'
  require_relative '../../config/lambda'

  Hanami.app.prepare
else
  require 'hanami/cucumber'
end
