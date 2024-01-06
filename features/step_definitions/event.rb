# frozen_string_literal: true

require 'hanami/utils/hash'

LambdaContext = Struct.new(:function_name)

Given('a event payload') do |payload|
  @payload = JSON.parse(payload)
end

When('the event {string} is triggered') do |function_name|
  @output = app.handle_lambda(event: @payload, context: LambdaContext.new(function_name:))
end

Then('the handler should return') do |payload|
  expected = Hanami::Utils::Hash.deep_symbolize(JSON.parse(payload))
  expect(@output).to eq(expected)
end
