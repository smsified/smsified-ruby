module Smsified
  class Response
    attr_reader :data, :http
    
    ##
    # Provides the standard response for the library
    #
    # @param [Object] an HTTParty result object
    def initialize(httparty)
      @data = httparty.parsed_response
      @http = httparty.response
    end
  end
end