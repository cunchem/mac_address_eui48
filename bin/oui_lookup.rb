#!/usr/bin/env ruby
# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@insa-lyon.fr>
require 'mac_address_eui48.rb'
require 'optparse'

options = {}
optp = OptionParser.new do |opts|
  opts.banner = "Usage: oui_lookup.rb [options] <mac_address>
    Copyright (C) 2015 Mathieu Cunche <mathieu.cunche@insa-lyon.fr>"
  
  options[:help] = false
  opts.on("-h", "--help", "Show this help") do 
    puts opts
    exit
    options[:help] = true
  end
end.parse!

# Check required conditions
if ARGV.empty?
  puts optp
  exit(-1)
end


mac = ARGV.pop
resolver = MacAddressEui48::OuiResolver.new()
oui = resolver.oui_lookup(mac)
puts oui

