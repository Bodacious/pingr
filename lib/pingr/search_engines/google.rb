# frozen_string_literal: true

module Pingr
  module SearchEngines
    require 'pingr/search_engines/base'
    class Google < Base
      private

      def search_engine
        :google
      end

      # Private: The path to ping to submit sitemaps for this search_engine
      #
      # Returns URI
      def ping_url
        URI("https://www.google.com/webmasters/tools/ping?sitemap=#{URI.escape(sitemap_url)}")
      end
    end
  end
end
