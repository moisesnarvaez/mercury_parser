require 'mercury_parser/configuration'
require 'mercury_parser/client'

module MercuryParser
  extend Configuration

  class << self
    # Alias for MercuryParser::Client.new
    #
    # @return [MercuryParser::Client]
    def new(options = {})
      MercuryParser::Client.new(options)
    end

    # Delegate to MercuryParser::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end # MercuryParser
