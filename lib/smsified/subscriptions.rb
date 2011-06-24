module Smsified
  class Subscriptions
    include Helpers
        
    include HTTParty
    format :json
    
    ##
    # Intantiate a new class to work with subscriptions
    # 
    # @param [required, Hash] params to create the user
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
    # Creates an inbound subscription
    # 
    # @param [required, String] destination_address to subscribe to
    # @param [required, Hash] params to send an sms
    # @option params [optional, String] :notify_url to send callbacks to
    # @option params [optional, String] :client_correlator to update
    # @option params [optional, String] :callback_data to update
    # @return [Object] A Response Object with http and data instance methods
    # @param [required, String] notify_url to send callbacks to
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.create_inbound_subscription('tel:+14155551212', :notify_url => 'http://foobar.com')
    def create_inbound_subscription(destination_address, options)
      query = options.merge({ :destination_address => destination_address })
      
      Response.new self.class.post("/smsmessaging/inbound/subscriptions", 
                                   :basic_auth => @auth,
                                   :body       => camelcase_keys(query))
    end
    
    ##
    # Creates an outbound subscription
    # 
    # @param [required, String] sender_address to subscribe to
    # @option params [optional, String] :notify_url to send callbacks to
    # @option params [optional, String] :client_correlator to update
    # @option params [optional, String] :callback_data to update
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.create_outbound_subscription('tel:+14155551212', :notify_url => 'http://foobar.com')    
    def create_outbound_subscription(sender_address, options)
      Response.new self.class.post("/smsmessaging/outbound/#{sender_address}/subscriptions", 
                                   :basic_auth => @auth,
                                   :body       => camelcase_keys(options))
    end
    
    ##
    # Deletes an inbound subscription
    # 
    # @param [required, String] subscription_id to delete
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.delete_inbound_subscription('89edd71c1c7f3d349f9a3a4d5d2d410c')
    def delete_inbound_subscription(subscription_id)
      Response.new self.class.delete("/smsmessaging/inbound/subscriptions/#{subscription_id}", :basic_auth => @auth)
    end
    
    ##
    # Deletes an outbound subscription
    # 
    # @param [required, String] subscription_id to delete
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.delete_outbound_subscription('89edd71c1c7f3d349f9a3a4d5d2d410c')
    def delete_outbound_subscription(sender_address)
      Response.new self.class.delete("/smsmessaging/outbound/subscriptions/#{sender_address}", :basic_auth => @auth)
    end
    
    ##
    # Fetches the inbound subscriptions
    #
    # @param [required, String] destination_address to fetch the subscriptions for
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.inbound_subscriptions('tel:+14155551212')
    def inbound_subscriptions(destination_address)
      Response.new self.class.get("/smsmessaging/inbound/subscriptions?destinationAddress=#{destination_address}", :basic_auth => @auth)
    end

    ##
    # Fetches the outbound subscriptions
    #
    # @param [required, String] sender_address to fetch the subscriptions for
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.outbound_subscriptions('tel:+14155551212')
    def outbound_subscriptions(sender_address)
      Response.new self.class.get("/smsmessaging/outbound/subscriptions?senderAddress=#{sender_address}", :basic_auth => @auth)
    end
    
    ##
    # Updates an inbound subscription
    # 
    # @option params [required, String] subscription_id updating
    # @param [required, Hash] params to update the inbound subscription with
    # @option params [optional, String] :notify_url to send callbacks to
    # @option params [optional, String] :client_correlator to update
    # @option params [optional, String] :callback_data to update
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.update_inbound_subscription('89edd71c1c7f3d349f9a3a4d5d2d410c', :notify_url => 'foobar')
    def update_inbound_subscription(subscription_id, options)
      Response.new self.class.post("/smsmessaging/inbound/subscriptions/#{subscription_id}", 
                                   :basic_auth => @auth,
                                   :body       => camelcase_keys(options))
    end
    
    ##
    # Updates an outbound subscription
    # 
    # @option params [required, String] sender_address updating
    # @param [required, Hash] params to update the outbound subscription with
    # @option params [optional, String] :notify_url to send callbacks to
    # @option params [optional, String] :client_correlator to update
    # @option params [optional, String] :callback_data to update
    # @return [Object] A Response Object with http and data instance methods
    # @example
    #   subscriptions.update_outbound_subscription('tel:+14155551212', :notify_url => 'foobar')
    def update_outbound_subscription(sender_address, options)
      Response.new self.class.post("/smsmessaging/outbound/#{sender_address}/subscriptions", 
                                   :basic_auth => @auth,
                                   :body       => camelcase_keys(options))
    end
  end
end