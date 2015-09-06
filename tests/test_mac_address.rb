# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@innsa-lyon.fr>

require "./lib/mac_address_eui48.rb"
require "test/unit"

module MacAddressEui48

  
  class TestMacAddress < Test::Unit::TestCase
    def test_initialize
      string="aa:bb:cc:dd:ee:ff"
      assert_nothing_raised do 
        mac1=MacAddress.new(string)
        mac2=MacAddress.new(42)
        mac3=MacAddress.new(mac2)
      end
    end
    
    def test_to_s
      string="aa:bb:cc:dd:ee:ff"
      mac=MacAddress.new(string)
      assert((mac.to_s <=> string)==0,"failed to_string conversion #{string} #{mac.to_s}")
    end

        
    def test_oui_lookup
      
      assert(MacAddressEui48::oui_lookup("9C:93:4E:12:34:56") == "Xerox Corporation", "Got [#{MacAddressEui48::oui_lookup("9C:93:4E:12:34:56")}] expected [Xerox Corporation]")
      assert(MacAddressEui48::oui_lookup("C4:04:15:12:34:56") == "NETGEAR INC.,")
      assert(MacAddressEui48::oui_lookup("A4:D1:8C:AB:CD:EF") == "Apple, Inc.")
      assert(MacAddressEui48::oui_lookup("F4:CA:E5:12:34:56") == "FREEBOX SA")
      
    end

    def test_next
      s1="AA:BB:CC:11:22:33"
      s2="AA:BB:CC:11:22:34"
      mac1 = MacAddress.new(s1)
      mac2 = MacAddress.new(s2)
      assert( mac1.next == mac2 , "Wrong successor of [#{mac1}]: got [#{mac1.next}] instead of  [#{mac2}]")
      
      s1="FF:FF:FF:FF:FF:FF"
      s2="00:00:00:00:00:00"
      mac1 = MacAddress.new(s1)
      mac2 = MacAddress.new(s2)
      assert( mac1.next == mac2 , "Wrong successor of [#{mac1}]: got [#{mac1.next}] instead of  [#{mac2}]")
    end
    
    def test_range_iterator
      mac1 = MacAddress.new("AA:BB:CC:11:22:00")
      mac2 = MacAddress.new("AA:BB:CC:11:22:0F")
      array = ["AA:BB:CC:11:22:00","AA:BB:CC:11:22:01","AA:BB:CC:11:22:02","AA:BB:CC:11:22:03","AA:BB:CC:11:22:04","AA:BB:CC:11:22:05","AA:BB:CC:11:22:06","AA:BB:CC:11:22:07","AA:BB:CC:11:22:08","AA:BB:CC:11:22:09","AA:BB:CC:11:22:0A","AA:BB:CC:11:22:0B","AA:BB:CC:11:22:0C","AA:BB:CC:11:22:0D","AA:BB:CC:11:22:0E","AA:BB:CC:11:22:0F"]
      i = 0
      (mac1..mac2).each do |mac|
        assert(mac==MacAddress.new(array[i]))
        i+=1
      end
    end


    def test_is_broadcast
      mac1 = MacAddress.new("AA:BB:CC:11:22:33")
      assert(!mac1.is_broadcast)
      mac2 = MacAddress.new("FF:FF:FF:FF:FF:FF")
      assert(mac2.is_broadcast)
      
    end

  end
end
