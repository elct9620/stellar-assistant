# frozen_string_literal: true

Hanami.app.register_provider :google_authorizer do
  prepare do
    require 'google/apis/sheets_v4'
    require 'googleauth'
  end

  start do
    secret = target[:secret]
    service_account = secret.get(:SPREADSHEET_SERVICE_ACCOUNT)

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(service_account),
      scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    )

    authorizer.fetch_access_token!

    register(:google_authorizer, authorizer)
  end
end
