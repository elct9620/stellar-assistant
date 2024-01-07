# frozen_string_literal: true

require 'secrets'

module Stellar
  class Settings < Hanami::Settings
    # Define your app settings here, for example:
    #
    # setting :my_flag, default: false, constructor: Types::Params::Bool

    setting :spreadsheet_id, default: '', constructor: Types::String
    setting :telegram_chat_id, default: '', constructor: Types::String

    setting :aws do
      setting :session_token, default: '', constructor: Types::String
    end

    setting :secret do
      setting :name, default: 'stellar-secret', constructor: Types::String
    end

    setting :openai do
      setting :model, default: 'gpt-3.5-turbo-16k', constructor: Types::String
      setting :temperature, default: 0.0, constructor: Types::Float
    end
  end
end
