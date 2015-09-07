# Copyright (C) 2015  Mathieu Cunche <mathieu.cunche@innsa-lyon.fr>


class Hash
  def safe_invert
    self.each_with_object( {} ) { |(key, value), out| ( out[value] ||= [] ) << key }
  end
end

module MacAddressEui48  

  
  class OuiResolver
    def initialize()
      @oui_hash=Hash.new(nil)
      path = File.expand_path('../../../data/oui.txt', __FILE__)
      oui_file = File.open(path)
      
      oui_file.each_line do |line|
        if (line =~ /\(hex\)/) then
          prefix = line.split("\t")[0].split(" ")[0].gsub("-",":").chomp
          oui = line.split("\t")[2].chomp
          @oui_hash[prefix]=oui
        end  
      end
      @reverse_oui_hash= @oui_hash.safe_invert
      @vendor_table=@oui_hash.values
      
    end
    def oui_lookup(mac_addr)
      return @oui_hash[mac_addr[0..7].upcase]
    end
    def reverse_lookup(vendor)
      return @reverse_oui_hash[vendor]
    end
    def has_oui(mac)
      return (oui_lookup(mac) != nil) 
    end
    
    def random_mac
      i = rand(2**48)
      return MacAddressEui48::int_to_macaddr(i).upcase
    end
    def random_oui_mac 
      # Some vendors may appear more than once in the OUI table 
      # All vendors don't have the same probability to be picked
      n = @vendor_table.size
      vendor = @vendor_table[rand(n)]
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
