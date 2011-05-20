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

Documentation
-------------

May be found at http://tropo.github.com/smsified & http://smsified.com.

License
-------

MIT - See LICENSE.txt