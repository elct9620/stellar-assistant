# frozen_string_literal: true

Given('there are some news feeds') do |table|
  repo = Class.new do
    def initialize(items)
      @items = items
    end

    def where(...)
      @items
    end
  end

  items = table.hashes.map do |item|
    Hanami::Utils::Hash.deep_symbolize(item)
  end
  app.container.stub('repositories.news_feeds', repo.new(items))
end
