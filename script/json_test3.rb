#!/usr/bin/env ruby
#
#require "json"
require 'yajl/json_gem'
require "json"

 
class JSONExample
  attr_accessor :name

  def self.json_create(o)
    s = new
    s.name = o["data"]["name"]
    s
  end
end

json_string = "{\"json_class\":\"JSONExample\",\"data\":{\"name\":\"my_example_json\"}}"
puts JSON.parse(json_string).class

