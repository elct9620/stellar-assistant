# frozen_string_literal: true

require 'hanami/cucumber'
require 'dry/system/stubs'

Hanami.app.container.enable_stubs!

Before do
  client = Class.new do
    api_klass = Class.new do
      def send_message(...); end
    end

    define_method(:api) do
      api_klass.new
    end
  end

  app.container.stub(:telegram, client.new)
end

After do
  app.container.unstub
end
