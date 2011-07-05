smsified
========

SMSified is a simple API for sending and receiving text messages using regular phone numbers or short codes. SMSified uses a simple REST interface based on the GSMA OneAPI standard and is backed by Voxeo - the worlds largest communications cloud. Ruby lib for consuming the SMSified OneAPI.

This is a Ruby gem for consuming the SMSified OneAPI.

Installation
------------

	gem install smsified
 
Example
-------

Send an SMS:

	require 'rubygems'
	require 'smsified'
	oneapi = Smsified::OneAPI.new(:username => 'user', :password => 'bug.fungus24')
	oneapi.send_sms :address => '14155551212', :message => 'Hi there!', :sender_address => '13035551212'


Find a subscription:

	require 'rubygems'
	require 'smsified'
	subscriptions = Smsified::Subscriptions.new(:username => 'user', :password => 'bug.fungus24')
	subscriptions.inbound_subscriptions('17177455076')

Parse the JSON for a callback Incoming Message:

    require 'rubygems'
    require 'smsified'
    # Also require your favorite web framework such as Rails or Sinatra
    incoming_message = Smsified::IncomingMessage.new json_body
	puts incoming_message.date_time           # Wed May 11 18:05:54 UTC 2011
    puts incoming_message.destination_address # '16575550100'
    puts incoming_message.message             # 'Inbound test'
    puts incoming_message.message_id          # 'ef795d3dac56a62fef3ff1852b0c123a'
    puts incoming_message.sender_address      # '14075550100'

Documentation
-------------

May be found at http://smsified.github.com/smsified-ruby & http://smsified.com.

License
-------

MIT - See LICENSE.txt