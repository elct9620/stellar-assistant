# frozen_string_literal: true

Hanami.app.register_provider :spreadsheet do
  prepare do
    require 'google/apis/sheets_v4'
  end

  start do
    client = Google::Apis::SheetsV4::SheetsService.new
    client.authorization = target[:google_authorizer]

    register(:spreadsheet, client)
  end
end
