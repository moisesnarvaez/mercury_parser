require 'multi_json'

module MercuryParser
  class Error < StandardError

    # Raised when Mercury returns a 4xx or 500 HTTP status code
    class ClientError < Error

      # Creates a new error from an HTTP environement
      #
      # @param response [Hash]
      # @return [MercuryParser::Error::ClientError]
      def initialize(error = nil)
        parsed_error = parse_error(error)
        http_error = error.response[:status].to_i

        if ERROR_MAP.has_key?(http_error)
          raise ERROR_MAP[http_error].new(parsed_error[:messages])
        else
          super
        end
      end


      private

      def parse_error(error)
        MultiJson.load(error.response[:body], :symbolize_keys => true)
      end
    end # ClientError

    class ConfigurationError < MercuryParser::Error; end

    # Raised when there's an error in Faraday
    class RequestError < MercuryParser::Error; end

    # Raised when MercuryParser returns a 400 HTTP status code
    class BadRequest < MercuryParser::Error; end

    # Raised when MercuryParser returns a 401 HTTP status code
    class UnauthorizedRequest < MercuryParser::Error; end

    # Raised when MercuryParser returns a 403 HTTP status code
    class Forbidden < MercuryParser::Error; end

    # Raised when MercuryParser returns a 404 HTTP status code
    class NotFound < MercuryParser::Error; end

    # Raised when MercuryParser returns a 500 HTTP status code
    class InternalServerError < MercuryParser::Error; end

    ERROR_MAP = {
      400 => MercuryParser::Error::BadRequest,
      401 => MercuryParser::Error::UnauthorizedRequest,
      403 => MercuryParser::Error::Forbidden,
      404 => MercuryParser::Error::NotFound,
      500 => MercuryParser::Error::InternalServerError
    }
  end # Error
end
