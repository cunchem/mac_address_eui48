#!/usr/bin/env ruby
# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@insa-lyon.fr>
require 'mac_address_eui48.rb'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: gen_mac_address.rb [options]
    gen_mac_address (mac_address_eui4)
    Copyright (C) 2015 Mathieu Cunche <mathieu.cunche@insa-lyon.fr>"
 

  options[:verbose] = false
  opts.on("-v", "--[no-]verbose", "Run verbosely") do 
    options[:verbose] = true
  end

  options[:oui] = nil
  opts.on("-o OUI", "--oui OUI", "OUI (Oragnization Unique Identifier)") do |v|
    options[:oui] = v
  end

  options[:registered] = false
  opts.on("-r", "--registered", "Generate random MAC from registered OUIs (disabled by default)") do |v|
    options[:registered] = true
  end

  options[:number] = 1
  opts.on("-n N", "--number N", "Number of MAC address to generate") do |v|
    options[:number] = v
  end
 
  options[:help] = false
  opts.on("-h", "--help", "Show this help") do 
    puts opts
    exit
    options[:help] = true
  end
end.parse!

#p options
#p ARGV



resolver = MacAddressEui48::OuiResolver.new()
options[:number].to_i.times do 
  if (options[:oui]==nil) then
    if(options[:registered])then 
      mac = resolver.random_oui_mac
    else
      mac = resolver.random_mac
    end
  else
    mac = resolver.random_mac_vendor(options[:oui])
  end
  puts mac
end
