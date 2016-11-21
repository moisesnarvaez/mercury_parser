module MercuryParser
  module API
    module Content

      # Parse a webpage and return its main content
      # Returns a MercuryParser::Article object
      #
      # Optionally pass the ID of an article as `id => "id"` in `options` to return the content for a specific DOM node
      # You can also pass a `max_pages` integer to set the maximum number of pages to parse and combine. Default is 25.
      #
      # @param url [String] The URL of an article to return the content for
      # @return [MercuryParser::Article]
      def parse(url, options = {})
        params = { url: url }
        response = get('', params.merge(options))

        MercuryParser::Article.new(response)
      end
    end # Content
  end # API
end
