#class dhcpserver::host
# This class is meant to be called from dhcpserver
# It set variable according to platform
class dhcpserver::host(){
  if($::dhcpserver::host_enabled){   
 		each($::dhcpserver::host) |Integer $index, String $value|{
        dhcp::host{$::dhcpserver::host[$index]:
          comment => $::dhcpserver::comment[$index],
          mac    => $::dhcpserver::mac[$index],
          ip   => $::dhcpserver::ip[$index]          
        }
      }

  }

}
