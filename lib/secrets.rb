# frozen_string_literal: true

module Secrets
  class Error < StandardError
  end

  class UnableLoadSecretsError < Error
  end

  class UnsupportedProviderError < Error
  end

  PROVIDER_BUILDERS = {
    'Secrets::File' => ->(config) { Secrets::File.new(config.file.root) },
    'Secrets::Aws' => ->(config) { Secrets::Aws.new(config.aws.host, config.aws.port) }
  }.freeze

  require_relative 'secrets/types'
  require_relative 'secrets/secret'
  require_relative 'secrets/aws'
  require_relative 'secrets/file'

  extend Dry::Configurable

  setting :provider, default: Secrets::File, constructor: Types::Class

  setting :file do
    setting :root, default: Dir.pwd, constructor: Types::String
  end

  setting :aws do
    setting :host, default: 'localhost', constructor: Types::String
    setting :port, default: ENV.fetch('PARAMETERS_SECRETS_EXTENSION_HTTP_PORT', 2773).to_i,
                   constructor: Types::Params::Integer
  end

  def self.build
    builder = PROVIDER_BUILDERS.fetch(config.provider.name)
    raise UnsupportedProviderError, config.provider.name unless builder

    builder.call(config)
  end
end
