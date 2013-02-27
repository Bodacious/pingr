require "pingr/version"
require "pingr/request"

module Pingr
  
  class PingrError < StandardError; end
  
  # Currently supported search engines
  SUPPORTED_SEARCH_ENGINES = [:google, :bing]
  
  def self.mode=(mode_name)
    @mode = mode_name.to_sym
  end
  
  def self.mode
    @mode ||= begin
      if defined?(Rails) && Rails.env.production?
        :live
      else
        :test
      end
    end
  end

end
