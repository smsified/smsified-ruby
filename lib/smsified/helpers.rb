module Smsified
  module Helpers
    private
    
    ##
    # Camelcases the options
    def camelcase_keys(options)
      options = options.clone
      
      if options[:destination_address]
        options[:destinationAddress] = options[:destination_address]
        options.delete(:destination_address)
      end
      
      if options[:notify_url]
        options[:notifyURL] = options[:notify_url]
        options.delete(:notify_url)
      end
      
      if options[:client_correlator]
        options[:clientCorrelator] = options[:client_correlator]
        options.delete(:client_correlator)
      end
      
      if options[:callback_data]
        options[:callbackData] = options[:callback_data]
        options.delete(:callback_data)
      end
      
      options
    end
  end
end