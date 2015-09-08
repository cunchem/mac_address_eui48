# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@innsa-lyon.fr>

module MacAddressEui48  
 
  
  class MacAddress
    include Comparable
        
    def initialize(arg)
      case arg
      when MacAddress
        @val = arg.to_i
      when Integer 
        @val = arg
      when String
        # String value must be provided as hex char separated by ':'
        if (MacAddressEui48::is_valid_mac(arg)) then 
          @mac_str=arg
          @val=MacAddressEui48::str_mac_to_int(arg)
        else
          raise "Wrong format for string mac address #{arg}"
        end
      else
        raise "Incompatible type for MacAddress Initialization: #{arg.class}"
      end
    end
    
    def to_i
      @val
    end
    
    def <=>(other)
      self.to_i <=> other.to_i
    end
    
    def to_s(sep=':')
      MacAddressEui48::int_to_str_mac(@val,sep).upcase
    end
  
    def is_broadcast
      #self.to_s ==  "FF:FF:FF:FF:FF:FF"
      @val == 2**48-1
    end
   
    def is_unicast
      !is_multicast
    end
    
    def is_multicast
      mask = 1 << (5*8)
      (mask & @val) !=0
    end
    
    def is_glob_uniq
      !is_loc_admin
    end
    
    def is_loc_admin
      mask = 2 << (5*8)
      (mask & @val) !=0 
    end

    def next
      return MacAddress.new(((self.to_i) +1)%2**48)
    end
    alias_method :succ, :next
    
  end
end
