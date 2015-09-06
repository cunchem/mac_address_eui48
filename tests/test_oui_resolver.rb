# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@innsa-lyon.fr>

require "./lib/mac_address_eui48.rb"
require "test/unit"

module MacAddressEui48
  class TestMacAddress < Test::Unit::TestCase
        
    def test_oui_lookup
      resolver=OuiResolver.new()
      
      assert(resolver.oui_lookup("9C:93:4E:12:34:56") == "Xerox Corporation", "Got [#{resolver.oui_lookup("9C:93:4E:12:34:56")}] expected [Xerox Corporation]")
      assert(resolver.oui_lookup("C4:04:15:12:34:56") == "NETGEAR INC.,")
      assert(resolver.oui_lookup("A4:D1:8C:AB:CD:EF") == "Apple, Inc.")
      assert(resolver.oui_lookup("F4:CA:E5:12:34:56") == "FREEBOX SA")
      assert(resolver.oui_lookup("FF:FF:FF:AB:CD:EF") == nil)
    end
    
    def test_reverse_lookup
      resolver=OuiResolver.new()
      
      # test 1: one prefix
      vendor = "Xerox Corporation"
      result  = resolver.reverse_lookup(vendor)
      prefixes = ["9C:93:4E"]
      assert((result <=> prefixes) == 0, "Got #{result} instead of #{prefixes}")
      
      # test 2: multiple prefixes
      vendor = "GUANGDONG OPPO MOBILE TELECOMMUNICATIONS CORP.,LTD"
      result  = resolver.reverse_lookup(vendor)
      prefixes = ["BC:3A:EA", "E8:BB:A8", "8C:0E:E3", "2C:5B:B8", "B0:AA:36", "A8:1B:5A", "A4:3D:78", "A0:93:47"] 
      assert((result <=> prefixes) == 0, "Got #{result} instead of #{prefixes}")
      
      # test 3: no prefix
      vendor = "ACME Corp."
      result  = resolver.reverse_lookup(vendor)
      prefixes = []
      assert((result <=> prefixes) == 0, "Got #{result} instead of #{prefixes}")


    end
    def test_random_mac
      resolver=OuiResolver.new()
      (0..10).each do |i|
        mac = resolver.random_mac
        assert(mac.size == 17, "wrong length for random mac #{mac}")
        assert(MacAddressEui48::is_valid_mac(mac), "wrong format for random #{mac}")
      end
    end
    def test_random_oui_mac
      resolver=OuiResolver.new()
      (0..10).each do |i|
        mac = resolver.random_oui_mac
        assert(mac.size == 17, "wrong length for random mac #{mac}")
        assert(MacAddressEui48::is_valid_mac(mac), "wrong format for random #{mac}")
        assert(resolver.has_oui(mac))
      end
    end
    def test_random_mac_vendor
      resolver=OuiResolver.new()
      
      vendor = "NETGEAR INC.,"
      (0..10).each do |i|
        mac = resolver.random_mac_vendor(vendor)
        assert(mac.size == 17, "wrong length for random mac #{mac}")
        assert(MacAddressEui48::is_valid_mac(mac), "wrong format for random #{mac}")
        assert(resolver.oui_lookup(mac) == vendor, "wrong vendor: got #{resolver.oui_lookup(mac)} instead of #{vendor} for #{mac}")
      end
    end
    def test_has_oui
      resolver=OuiResolver.new()
      assert(resolver.has_oui("A4:D1:8C:AB:CD:EF"))
      assert(resolver.has_oui("F4:CA:E5:12:34:56"))
      assert(!resolver.has_oui("FF:FF:FF:AB:CD:EF"))

    end
    
  end
end
