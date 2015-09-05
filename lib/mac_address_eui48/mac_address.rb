
module MacAddressEui48  
 
  
  class MacAddress
    include Comparable
    attr_reader :mac_str
    
    def initialize(arg)
      case arg
      when MacAddress
        @mac_str = arg.to_s
      when Integer 
        @mac_str = MacAddressEui48::int_to_macaddr(arg)
      when String
        if (MacAddressEui48::is_valid_mac(arg)) then 
          @mac_str=arg
        else
          raise "Wrong format for string mac address #{arg}"
        end
      else
        raise "Incompatible type for MacAddress Initialization: #{arg.class}"
      end
    end
    
    
    def to_i
      return MacAddressEui48::macaddr_to_int(@mac_str)
    end
    
    def <=>(other)
      MacAddressEui48::macaddr_to_int(self.mac_str) <=> MacAddressEui48::macaddr_to_int(other.mac_str)
    end
    
    def to_s
      @mac_str  
    end
  
    def is_broadcast
      self.mac_str ==  "FF:FF:FF:FF:FF:FF"
    end
   
    def is_unicast
      return !is_multicast
    end
    def is_multicast
      
    end
    def is_glob_uniq
      return !is_loc_admin
    end
    def is_loc_admin
      
    end
    

    def next
      return MacAddress.new(MacAddressEui48::int_to_macaddr(((self.to_i) +1)%2**48))
    end
    alias_method :succ, :next
    
  end
end
