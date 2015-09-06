# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@innsa-lyon.fr>

module MacAddressEui48  
  class OuiResolver
    def initialize()
      @hash=Hash.new(nil)
      
      oui_file = File.open(OUI_FILE)
      oui_file.each_line do |line|
        if (line =~ /\(hex\)/) then
          prefix = line.split("\t")[0].split(" ")[0].gsub("-",":").chomp
          oui = line.split("\t")[2].chomp
          @hash[prefix]=oui
        end
        
      end
    end
    def oui_lookup(mac_addr)
      return @hash[mac_addr[0..7].upcase]
    end
    def reverse_lookup(vendor)
      return @hash.select { |key, val| val == vendor }.keys 
    end
    def has_oui(mac)
      return (oui_lookup(mac) != nil) 
    end
    
    def random_mac
      i = rand(2**48)
      return MacAddressEui48::int_to_macaddr(i).upcase
    end
    def random_oui_mac 
      vendor = @hash.values.uniq[rand(@hash.values.uniq.size)]
      return random_mac_vendor(vendor)
    end
    
    def random_mac_vendor(vendor)
      ouis = reverse_lookup(vendor)
      if (ouis.size <=0) then
        raise "OUI not found #{vendor}"
      end
      oui = ouis[rand(ouis.size)]
      i1 =  MacAddressEui48::macaddr_to_int( oui + ":00:00:00")
      i2 = rand(2**24)       
      i = i1 + i2
      return MacAddressEui48::int_to_macaddr(i)
    end
    
  end
  
  
end
