class Pingr::Request

  include Logger

  attr_accessor :url, :search_engine, :response

  require 'net/http'
  require 'uri'

  def initialize(search_engine, url)
    self.search_engine = search_engine
    self.url = url
  end

  def ping_path
    case search_engine
      # http://www.google.com/webmasters/tools/ping?sitemap=
    when :google then "/webmasters/tools/ping?sitemap=#{URI.escape(url)}"
      # http://www.bing.com/ping?sitemap=
    when :bing then "/ping?sitemap=#{URI.escape(url)}"
    else
      raise PingrError, "Don't know how to ping search engine: #{search_engine}"
    end
  end

  def ping
    uri     = URI.parse("http://#{search_engine}.com#{ping_path}")
    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    self.response = http.request(request)
    if response.code.to_s =~ /200|301/
      logger.info "Pinged #{search_engine} Successfully - #{Time.now}"
    else
      logger.warn "Error pinging #{search_engine}! (response code: #{response.code})- #{Time.now}"
    end
  end

  private

  def logger
    @logger ||= Logger.new(name, shift_age = 'weekly')
  end
  
  def logger_name
    if defined?(Rails)
      Rails.join('log', "pingr.#{Rails.env}.log")
    else
      STDOUT
    end
  end
end

Base.new(:google, "http://gavinmorrice.com/blog/posts.xml").ping