# frozen_string_literal: true

require 'feedjira'
require 'async'
require 'async/barrier'
require 'async/http/internet'

module Stellar
  module Repositories
    class NewsFeeds
      include Enumerable
      include Deps[
        :settings,
        :spreadsheet
      ]

      SHEET_NAME = 'news_feeds'

      def each(&)
        return enum_for(:each) unless block_given?

        Async do
          internet = Async::HTTP::Internet.new

          in_parallel(sources) do |source|
            xml = internet.get(source).read
            extract_rss(xml, &)
          end
        ensure
          internet.close
        end
      end

      def where(newer_than:)
        select do |feed|
          feed[:published_at] > newer_than
        end
      end

      protected

      def in_parallel(sources)
        barrier = Async::Barrier.new

        sources.each do |source|
          barrier.async { yield(source) }
        end

        barrier.wait
      end

      def extract_rss(xml, &)
        feed = Feedjira.parse(xml)
        feed.entries.each do |entry|
          yield ({
            title: entry.title,
            summary: entry.summary,
            url: entry.url,
            published_at: entry.published
          })
        end
      end

      def sources
        @sources ||= rows.map(&:first)
      end

      def rows
        @rows ||= spreadsheet.get_spreadsheet_values(
          settings.spreadsheet_id,
          SHEET_NAME
        )&.values&.drop(1) || []
      end
    end
  end
end
