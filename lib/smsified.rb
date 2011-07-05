$LOAD_PATH.unshift(File.dirname(__FILE__))
%w(
 cgi 
 httparty 
 smsified/helpers 
 smsified/oneapi 
 smsified/subscriptions 
 smsified/reporting 
 smsified/response 
 smsified/incoming_message
).each { |lib| require lib }