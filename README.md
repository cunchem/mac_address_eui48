# MacAddressEui48

This is an implementation of MAC address along with tools for OUI lookup and random MAC address generation. It can be used as a Ruby library or through the command line tools. 

The OUI resolver is based on the official OUI file provided by the IEEE [http://standards-oui.ieee.org/oui.txt] and stored in data/.

## Features
### Command line tools

* gen_mac_address.rb: generate random MAC address
  * Fully random address
  * Generate multiple address at one time
  * Address with registered OUI
  * Address with given OUI
* oui_lookup.rb: resolve OUI of MAC address

### Library 


* MacAddressEui48::MacAddress
  * Initialization from Integer, String of MacAddress
  * Comparison operator
  * Possibility to iterate over a range of MacAddress
  * Test for Broadcast address
  * Flag tests: locally administered, multicast, ...

* MacAddressEui48::OuiResolver	
  * Lookup: Organization/Vendor from MAC address
  * Reverse lookup: OUI (MAC prefix) from Organization/Vendor 
  * Random MAC address generation
    * Over all space (2^48 values) 
    * Only within space of registered OUI
    * Over a specific OUI
   
## Installation

```ruby
gem 'mac_address_eui48'
```

## Usage

### Command line tools 

Generation of random MAC address
```bash
# fully random address
$ ./gen_mac_address.rb 
5A:79:5A:7D:FC:71

# random address in with registered OUI
$ ./gen_mac_address.rb -r
00:1C:AE:57:0E:BA

# multiple address
$ ./gen_mac_address.rb -n 5
3F:40:DC:4B:CC:EB
49:23:BC:D4:54:9D
85:F6:49:BB:CC:47
33:68:8A:9E:21:57
42:B6:80:B8:B0:7F

# random mac address from a given OUI (vendor)
$ ./gen_mac_address.rb -o "Xerox Corporation"
9C:93:4E:27:2A:16
```

### Library 

TODO


## Development
TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cunchem/mac_address_eui48. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

