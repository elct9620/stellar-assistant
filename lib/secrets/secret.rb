# frozen_string_literal: true

require 'json'
require 'hanami/utils/hash'

module Secrets
  class Secret
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def name
      attributes['Name']
    end

    def version_id
      attributes['VersionId']
    end

    def string?
      attributes.key?('SecretString')
    end

    def binary?
      attributes.key?('SecretBinary')
    end

    def payload
      @payload ||=
        if string?
          Hanami::Utils::Hash.deep_symbolize(
            JSON.parse(attributes['SecretString'])
          )
        elsif binary?
          attributes['SecretBinary']
        end
    rescue JSON::ParserError
      attributes['SecretString']
    end

    def dig(*keys)
      return unless payload.is_a?(Hash)

      payload.dig(*keys)
    end
    alias get dig

    def inspect
      "#<#{self.class.name} name=#{name.inspect} version_id=#{version_id.inspect} binary=#{binary?}>"
    end
  end
end
