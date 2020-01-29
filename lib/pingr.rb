# frozen_string_literal: true

require 'pingr/version'
require 'pingr/request'

module Pingr

  require 'logger'


  # Exceptions raised from within Pingr are of this class
  class PingrError < StandardError; end

  # Public: Set the mode Pingr is running in
  #
  # mode_name - A Symbol or String value for the mode. Must be one of :test or :live
  #
  # Raises PingrError if an invalid value is passed
  def self.mode=(mode_name)
    unless mode_name.to_s =~ /test|live/
      raise PingrError, "Unknown mode: #{mode_name}"
    end

    @mode = mode_name.to_sym
  end

  # Public: The mode Pingr is running in
  #
  # Returns a Symbol either :test or :live
  def self.mode
    @mode ||= begin
      if defined?(Rails) && Rails.env.production?
        :live
      else
        :test
      end
    end
  end

  # Public: A custom logger to keep track of the Pings
  #
  # Returns a Logger object. By default, the log clears itself every week
  def self.logger
    @logger ||= if defined?(Rails)
      Rails.logger
    else
      Logger.new(logger_name, shift_age = 'weekly')
    end
  end

  # Public: Sets the logger to be used.
  # If the developer would like to use their own custom logger, let 'em.
  def self.logger=(_logger)
    @logger = _logger
  end

  private

  # Private: The name of the Logger used by Pingr.
  # If we've detected a Rails app, sets up a log file in the log directory.
  # Otherwise, use STDOUT
  #
  # Returns a String with the logger name or an IO object
  def self.logger_name
    if defined?(Rails)
      Rails.root.join('log', "#{Rails.env}.log").to_s
    else
      STDOUT
    end
  end
end
