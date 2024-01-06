# frozen_string_literal: true

module Secrets
  class File
    attr_reader :root

    def initialize(root)
      @root = Pathname.new(root)
    end

    def get_secret(name)
      payload = JSON.parse(root.join("config/secrets/#{name}.json").read)
      Secret.new(payload)
    end
  end
end
