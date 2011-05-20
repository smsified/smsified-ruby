$LOAD_PATH.unshift(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'smsified'
require 'yaml'

config = YAML.load(File.open('examples/config.yml'))

smsified = Smsified::OneAPI.new :username       => config['smsified']['username'],
                                :password       => config['smsified']['password']

# Send an SMS to one address
result = smsified.send_sms :message        => 'Hello there!', 
                           :address        => '14157044517',
                           :notify_url     => config['postbin'],
                           :sender_address => '17177455076'
puts result.data.inspect
puts result.http.inspect
                           
# Send an SMS to multiple addresses
result = smsified.send_sms :message        => 'Hello there!', 
                           :address        => ['14157044517', '14153675082'],
                           :notify_url     => config['postbin'],
                           :sender_address => '17177455076'
puts result.data.inspect
puts result.http.inspect

# Create in inbound subscription
result = smsified.create_inbound_subscription '17177455076', :notify_url => config['postbin']
puts result.data.inspect
puts result.http.inspect

# Get some of your sent SMS details
result = smsified.search_sms 'startDate=2011-02-14&endDate=2011-02-15'
puts result.data.inspect
puts result.data.inspect

                                


