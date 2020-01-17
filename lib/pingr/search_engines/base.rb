# frozen_string_literal: true

module Pingr
  module SearchEngines
    # Public: The object created to ping a search engine with a sitemap
    class Base
      require 'net/http'
      require 'uri'

      # Public: Gets/Sets the String url of the sitemap we're submitting
      attr_reader :sitemap_url

      # Public: Initialize a new ping request
      #
      # sitemap_url - A String url of the sitemap we're submitting
      #
      # Returns a Pingr::Request object
      def initialize(sitemap_url)
        @sitemap_url = sitemap_url
      end

      # Public: Perform the ping request (if in :live mode)
      # Logs the success/failure of the ping in logger.
      #
      # Returns true if ping was a success
      # Returns false if ping was not successful
      def ping
        return true unless Pingr.mode == :live
        ssl = ping_url.scheme == 'https'
        Net::HTTP.start(ping_url.host, ping_url.port, use_ssl: ssl) do |http|
          request = Net::HTTP::Get.new(ping_url)
          response = http.request(request)
          if response.code.to_s =~ /200|301/
            logger.info "Pinged #{search_engine} Successfully - #{Time.now}"
            return true
          else
            logger.warn "Error pinging #{search_engine}! (response code: #{response.code})- #{Time.now}"
            return false
          end
        end
      end

      private

      def ping_url
        raise NotImplementedError, "Define ping_url in #{self.class}"
      end

      def search_engine
        raise NotImplementedError, "Define search_engine in #{self.class}"
      end

      # Private: A helper method to access Pingr::logger
      #
      # Returns A Logger instance
      def logger
        Pingr.logger
      end
    end
  end
end
