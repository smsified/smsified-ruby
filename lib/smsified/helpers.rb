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
    
    ##
    # Builds the necessary query string
    def build_query_string(options)
      options = camelcase_keys(options)
      
      query = ''

      options.each do |k,v|
        if k == :address
          if RUBY_VERSION.to_f == 1.9
            if v.instance_of?(String)
              v.each_line { |address| query += "#{ '&' if query != '' }address=#{CGI.escape address}" }
            else
              v.each { |address| query += "#{ '&' if query != '' }address=#{CGI.escape address}" }
            end
          else
            v.each { |address| query += "#{ '&' if query != '' }address=#{CGI.escape address}" }
          end
        else
          query += "#{ '&' if query != '' }#{k.to_s}=#{CGI.escape v}"
        end
      end

      query
    end
  end
end