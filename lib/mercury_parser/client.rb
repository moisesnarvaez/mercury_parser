require 'mercury_parser/connection'
require 'mercury_parser/request'
require 'mercury_parser/api/content'
require 'mercury_parser/article'

module MercuryParser
  class Client
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options = {})
      options = MercuryParser.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include MercuryParser::Connection
    include MercuryParser::Request
    include MercuryParser::API::Content
  end # Client
end
