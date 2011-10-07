#!/usr/bin/env ruby
require 'json'
class Thing
  attr_accessor :name
  def self.create_json(o)
    new
  end

  def to_json(*a)
    {
      "json_class"   => self.class.name,
      "data"         => {"name" => name }
    }.to_json(*a)
  end
end
 
thing = Thing.new
thing.name = "foo"
puts thing.to_json
json_string = "{\"json_class\":\"Thing\",\"data\":{\"name\":\"foo\"}}"
puts JSON.parse(json_string).class
