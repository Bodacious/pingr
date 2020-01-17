# frozen_string_literal: true

module Pingr
  # Public: The object created to ping a search engine with a sitemap
  class Request
    require 'pingr/search_engines/bing'
    require 'pingr/search_engines/google'

    # Public: Initialize a new ping request
    #
    # sitemap_url - A String url of the sitemap we're submitting
    #
    # Returns a Pingr::Request object
    def initialize(sitemap_url)
      Pingr::SearchEngines::Bing.new(sitemap_url).ping
      Pingr::SearchEngines::Google.new(sitemap_url).ping
    end
  end
end
