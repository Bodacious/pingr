# frozen_string_literal: true

module Pingr
  module SearchEngines
    require 'pingr/search_engines/base'

    class Bing < Base
      private

      def search_engine
        :bing
      end

      # Private: The path to ping to submit sitemaps for this search_engine
      #
      # Returns URI
      def ping_url
        URI("https://www.bing.com/ping?sitemap=#{URI.escape(sitemap_url)}")
      end
    end
  end
end
