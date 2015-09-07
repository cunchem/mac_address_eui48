#!/usr/bin/env ruby
# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@insa-lyon.fr>

require 'benchmark'
require 'mac_address_eui48.rb'

n = 50
Benchmark.bm(25) do |x|
  resolver = MacAddressEui48::OuiResolver.new()
  x.report("Init Resolver              :")   {resolver = MacAddressEui48::OuiResolver.new()}      
  x.report("random_mac       (#{n} times):")   { n.times do resolver.random_mac; end  }
  x.report("random_oui_mac   (#{n} times):")   { n.times do resolver.random_oui_mac; end  }
  x.report("random_mac_vendor(#{n} times):")   { n.times do resolver.random_mac_vendor("Apple, Inc."); end  }
  x.report("oui_lookup       (#{n} times):")   { n.times do resolver.oui_lookup(resolver.random_mac); end  }
  x.report("reverse_lookup   (#{n} times):")   { n.times do resolver.reverse_lookup(resolver.oui_lookup(resolver.random_mac)); end  }
end
