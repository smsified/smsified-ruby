module Smsified
  class IncomingMessage
    attr_reader :date_time, :destination_address, :message, :message_id, :sender_address, :json
    
    ##
    # Intantiate a new object to provide convenience methods on an Incoming Message
    # http://www.smsified.com/sms-api-documentation/receiving
    # 
    # @param [required, String] valid JSON for an Incoming Message to be parsed
    # @return [Object] the parsed incoming message
    # @raise [ArgumentError] if json is not valid JSON or an Incoming Message type
    # @example 
    #   incoming_message = IncomingMessage.new(json)
    #   puts incoming_message.message # foobar
    def initialize(json)
      begin
        @json                = JSON.parse json
        
        contents             = @json['inboundSMSMessageNotification']['inboundSMSMessage']
        
        @date_time           = contents['dateTime']
        @destination_address = contents['destinationAddress']
        @message             = contents['message']
        @message_id          = contents['messageId']
        @sender_address      = contents['senderAddress']
      rescue => error
        raise MessageError, "Not valid JSON or IncomingMessage"
      end
    end
    
    class MessageError < StandardError; end
  end
end