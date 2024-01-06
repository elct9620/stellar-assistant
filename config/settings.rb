# frozen_string_literal: true

require 'secrets'

module Stellar
  class Settings < Hanami::Settings
    # Define your app settings here, for example:
    #
    # setting :my_flag, default: false, constructor: Types::Params::Bool

    setting :aws do
      setting :session_token, default: '', constructor: Types::String
    end

    setting :secret do
      setting :name, default: 'stellar-secret', constructor: Types::String
    end
  end
end
