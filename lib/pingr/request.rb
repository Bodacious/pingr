module Pingr
  
  # Public: The object created to ping a search engine with a sitemap
  class Request

    require 'logger'
    require 'net/http' 
    require 'uri'

    # Public: Gets/Sets the String url of the sitemap we're submitting
    attr_accessor :sitemap_url
    
    # Public: Gets/Sets the String or Symbol name of the search engine we're pinging
    attr_accessor :search_engine

    # Public: Initialize a new ping request
    # 
    # search_engine - A String or Symbol name of the search engine we're pinging
    # sitemap_url - A String url of the sitemap we're submitting
    # 
    # Returns a Pingr::Request object
    def initialize(search_engine, sitemap_url)
      self.search_engine = search_engine.to_sym
      self.sitemap_url = sitemap_url
    end

    # Public: The path to ping to submit sitemaps for this search_engine
    # 
    # Returns a String with the correct path to submit sitemaps
    # 
    # Raises: A PingrError if the search_engine attribute's value is not supported
    def ping_path
      case search_engine
        # http://www.google.com/webmasters/tools/ping?sitemap=
      when :google then "webmasters/tools/ping?sitemap=#{URI.escape(sitemap_url)}"
        # http://www.bing.com/ping?sitemap=
      when :bing then "ping?sitemap=#{URI.escape(sitemap_url)}"
      else
        raise PingrError, "Don't know how to ping search engine: #{search_engine}"
      end
    end

    # Public: Perform the ping request (if in :live mode)
    # Logs the success/failure of the ping in logger.
    # 
    # Returns true if ping was a success
    # Returns false if ping was not successful
    def ping
      return true unless Pingr.mode == :live
      uri     = URI.parse("http://#{search_engine}.com/#{ping_path}")
      http    = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      if response.code.to_s =~ /200|301/
        logger.info "Pinged #{search_engine} Successfully - #{Time.now}"
        return true
      else
        logger.warn "Error pinging #{search_engine}! (response code: #{response.code})- #{Time.now}"
        return false
      end
    end

    private
    
    # Private: A helper method to access Pingr::logger
    # 
    # Returns A Logger instance
    def logger
      Pingr.logger
    end
    
  end
end