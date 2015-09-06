# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@innsa-lyon.fr>

require "./lib/mac_address_eui48.rb"
require "test/unit"

module MacAddressEui48
  class TestMacAddress < Test::Unit::TestCase
        
    def test_macaddr_to_int
      (0..10).each do |n|
        assert(MacAddressEui48::macaddr_to_int(MacAddressEui48::int_to_macaddr(n)) == n )
      end  
    end
    
    def test_is_valid_mac
      assert(MacAddressEui48::is_valid_mac("ab:cd:ef:12:34:56"))
      assert(MacAddressEui48::is_valid_mac("9C:93:4E:12:34:56"))
      assert(!MacAddressEui48::is_valid_mac("9C:93:4E:12:34:56:12"))
      assert(!MacAddressEui48::is_valid_mac("G9:93:4E:12:34:56:XX"))
      assert(!MacAddressEui48::is_valid_mac("19-93-4E-12-34-56"))
      assert(!MacAddressEui48::is_valid_mac("trolololololo"))
    end
  end
end
