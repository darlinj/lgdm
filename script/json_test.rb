#!/usr/bin/env ruby
require 'chef/node'
require 'json/pure'

json_string = "{\"name\":\"i-000FFTpR\",\"run_list\":[\"role[osss_frontend_test_server]\"],\"chef_type\":\"node\"}"
puts JSON.parse(fail).class
