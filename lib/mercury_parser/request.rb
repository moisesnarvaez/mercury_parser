require 'mercury_parser/error'

module MercuryParser
  module Request

    # Performs a HTTP Get request
    def get(path, params={})
      request(:get, path, params)
    end


    private

    # Returns a Faraday::Response object
    #
    # @return [Faraday::Response]
    def request(method, path, params = {})
      raise MercuryParser::Error::ConfigurationError.new("Please configure MercuryParser.api_key first") if api_key.nil?

      connection_options = {}
      begin
        response = connection(connection_options).send(method) do |req|
          req.url(path, params)
          req.headers['Content-Type'] = 'application/json'
          req.headers['x-api-key'] = api_key
        end
      rescue Faraday::Error::ClientError => error
        if error.is_a?(Faraday::Error::ClientError)
          raise MercuryParser::Error::ClientError.new(error)
        else
          raise MercuryParser::Error::RequestError.new(error)
        end
      end

      response.body
    end
  end # Request
end
