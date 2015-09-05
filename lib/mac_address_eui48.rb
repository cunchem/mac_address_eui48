require "mac_address_eui48/version"
require "mac_address_eui48/mac_address"
require "mac_address_eui48/oui_resolver"


module MacAddressEui48  
  OUI_FILE="data/oui.txt"
  
  # MAC address format is hexadecimal characters separated by ':'
  # ex: "AA:BB:CC:DD:EE:FF" or "11:22:33:44:55:66

  def MacAddressEui48::is_valid_mac(mac_addr)
    return (mac_addr =~ /^(\h\h:){5}\h\h$/)
  end
  
  def MacAddressEui48::macaddr_to_int(a)
    return a = a.delete(":").to_i(16)
  end
    
  def MacAddressEui48::int_to_macaddr(i)
    a = i.to_s(16)
    a = a.rjust(12,'0')
    a = a.insert(10,':').insert(8,':').insert(6,':').insert(4,':').insert(2,':')
    return a.upcase 
  end
  
  def  MacAddressEui48::oui_lookup(mac_addr)
    oui = ""
    mac_array=mac_addr.upcase.split(":")
    prefix = mac_array[0] + "-" + mac_array[1] + "-" + mac_array[2]
    oui_file = File.open(OUI_FILE)
    oui_file.each_line do |line|
      if (line =~ /.*#{prefix}.*(hex)/) then
        
        oui = line.split("\t")[2].chomp
      end
    end
    return oui
  end

  
end
