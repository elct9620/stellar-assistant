# frozen_string_literal: true

require 'hanami/cucumber'
require 'dry/system/stubs'

Hanami.app.container.enable_stubs!

After do
  app.container.unstub
end
