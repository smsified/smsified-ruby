module Smsified
  class Reporting
    include HTTParty
    format :json
    
    ##
    # Intantiate a new class to work with reporting
    # 
    # @param [required, Hash] params to create the Reporting object with
    # @option params [required, String] :username username to authenticate with
    # @option params [required, String] :password to authenticate with
    # @option params [optional, String] :base_uri of an alternative location of SMSified
    # @option params [optional, String] :destination_address to use with subscriptions
    # @option params [optional, String] :sender_address to use with subscriptions
    # @option params [optional, Boolean] :debug to turn on the HTTparty debugging to stdout
    # @example
    #   subscription = Subscription.new :username => 'user', :password => '123'
    def initialize(options)
      raise ArgumentError, 'an options Hash is required' if !options.instance_of?(Hash)
      raise ArgumentError, ':username required' if options[:username].nil?
      raise ArgumentError, ':password required' if options[:password].nil?
      
      self.class.debug_output $stdout if options[:debug]
      self.class.base_uri options[:base_uri] || SMSIFIED_ONEAPI_PUBLIC_URI
      @auth = { :username => options[:username], :password => options[:password] }
      
      @destination_address = options[:destination_address]
      @sender_address      = options[:sender_address]
    end
    
    ##
    # Get the delivery status of an outstanding SMS request
    #
    # @param [required, Hash] params to get the delivery status
    # @option params [required, String] :request_id to fetch the status for
    # @option params [optional, String] :sender_address used to send the SMS, required if not provided on initialization of OneAPI
    # @return [Object] A Response Object with http and data instance methods
    # @raise [ArgumentError] of :sender_address is not passed here when not passed on instantiating the object
    # @example
    #   one_api.delivery_status :request_id => 'f359193765f6a3149ca76a4508e21234', :sender_address => '14155551212'
    def delivery_status(options)
      raise ArgumentError, 'an options Hash is required' if !options.instance_of?(Hash)
      raise ArgumentError, ':sender_address is required' if options[:sender_address].nil? && @sender_address.nil?
      
      options[:sender_address] = options[:sender_address] || @sender_address

      Response.new self.class.get("/smsmessaging/outbound/#{options[:sender_address]}/requests/#{options[:request_id]}/deliveryInfos", :basic_auth => @auth)
    end
    
    ##
    # Retrieve a single SMS
    # 
    # @param [required, String] message_id of the message to retrieve
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   reporting.retrieve_sms '74ae6147f915eabf87b35b9ea30c5916'
    def retrieve_sms(message_id)
      Response.new self.class.get("/messages/#{message_id}", :basic_auth => @auth)
    end
    
    ##
    # Retrieve multiple SMS messages based on a query string
    # 
    # @param [required, String] query_string to search SMS messages for
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   reporting.search_sms 'start=2011-02-14&end=2011-02-15'
    def search_sms(query_string)
      Response.new self.class.get("/messages?#{query_string}", :basic_auth => @auth)
    end
  end
end