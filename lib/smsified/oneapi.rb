module Smsified
  SMSIFIED_ONEAPI_PUBLIC_URI = 'https://api.smsified.com/v1'
  SMSIFIED_HTTP_HEADERS      = { 'Content-Type' => 'application/x-www-form-urlencoded' }
  
  class OneAPI
    include Helpers
    
    include HTTParty
    format :json
    
    ##
    # Intantiate a new class to work with OneAPI
    # 
    # @param [required, Hash] params to create the user
    # @option params [required, String] :username username to authenticate with
    # @option params [required, String] :password to authenticate with
    # @option params [optional, String] :base_uri of an alternative location of SMSified
    # @option params [optional, String] :destination_address to use with subscriptions
    # @option params [optional, String] :sender_address to use with subscriptions
    # @option params [optional, Boolean] :debug to turn on the HTTparty debugging to stdout
    # @raise [ArgumentError] if :username is not passed as an option
    # @raise [ArgumentError] if :password is not passed as an option
    # @example 
    #   one_api = OneAPI.new :username => 'user', :password => '123'
    def initialize(options)
      raise ArgumentError, ':username required' if options[:username].nil?
      raise ArgumentError, ':password required' if options[:password].nil?
      
      self.class.debug_output $stdout if options[:debug]
      self.class.base_uri options[:base_uri] || SMSIFIED_ONEAPI_PUBLIC_URI
      @auth = { :username => options[:username], :password => options[:password] }
      
      @destination_address = options[:destination_address]
      @sender_address      = options[:sender_address]
      
      @subscriptions = Subscriptions.new(options)
      @reporting     = Reporting.new(options)
    end
    
    ##
    # Send an SMS to one or more addresses
    #
    # @param [required, Hash] params to send an sms
    # @option params [required, String] :address to send the SMS to
    # @option params [required, String] :message to send with the SMS
    # @option params [optional, String] :sender_address to use with subscriptions, required if not provided on initialization of OneAPI
    # @option params [optional, String] :notify_url to send callbacks to
    # @return [Object] A Response Object with http and data instance methods
    # @raise [ArgumentError] if :sender_address is not passed as an option when not passed on object creation
    # @raise [ArgumentError] if :address is not provided as an option
    # @raise [ArgumentError] if :message is not provided as an option
    # @example 
    #   one_api.send_sms :address => '14155551212', :message => 'Hi there!', :sender_address => '13035551212'
    #   one_api.send_sms :address => ['14155551212', '13035551212'], :message => 'Hi there!', :sender_address => '13035551212'
    def send_sms(options)
      raise ArgumentError, ':sender_address is required' if options[:sender_address].nil? && @sender_address.nil?
      raise ArgumentError, ':address is required' if options[:address].nil?
      raise ArgumentError, ':message is required' if options[:message].nil?
      
      options[:sender_address] = options[:sender_address] || @sender_address
      query_options = options.clone
      query_options.delete(:sender_address)
      query_options = camelcase_keys(query_options)

      Response.new self.class.post("/smsmessaging/outbound/#{options[:sender_address]}/requests",
                                   :body       => build_query_string(query_options),
                                   :basic_auth => @auth,
                                   :headers    => SMSIFIED_HTTP_HEADERS)
    end
    
    ##
    # Dispatches method calls to other objects for subscriptions and reporting
    def method_missing(method, *args)
      if method.to_s.match /subscription/
        if args.size == 2
          @subscriptions.send method, args[0], args[1]
        else
          @subscriptions.send method, args[0]
        end
      else
        if method == :delivery_status || method == :retrieve_sms || method == :search_sms
          @reporting.send method, args[0]
        else
          raise RuntimeError, 'Unknown method'
        end
      end
    end
    
    private
    
    ##
    # Builds the necessary query string
    def build_query_string(options)
      query = ''
      
      options.each do |k,v|
        if k == :address
          v.each { |address| query += "#{ '&' if query != '' }address=#{CGI.escape address}" }
        else
          query += "#{ '&' if query != '' }#{k.to_s}=#{CGI.escape v}"
        end
      end
      
      query
    end
  end
end