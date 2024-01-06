# frozen_string_literal: true

module Secrets
  class Aws
    attr_reader :host, :port
    attr_accessor :token

    def initialize(host, port, token: nil)
      @host = host
      @port = port
      @token = token
    end

    def get_secret(name)
      uri = URI("http://#{host}:#{port}/secretsmanager/get?secretId=#{name}")
      secret = get(uri)
      Secret.new(secret)
    end

    def get(uri)
      req = Net::HTTP::Get.new(uri)
      req['X-Aws-Parameters-Secrets-Token'] = @token
      res = http.request(req)
      raise UnableLoadSecretsError, res.body unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body)
    end

    def http
      @http ||= Net::HTTP.new(@host, @port)
    end
  end
end
