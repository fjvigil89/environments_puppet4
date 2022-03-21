#class dhcpserver::pool
# This class is meant to be called from dhcpserver
# It set variable according to platform
class dhcpserver::pool(){
  if($::dhcpserver::pool_enabled){
    each($::dhcpserver::pool) |Integer $index, String $value|{
        dhcp::pool{$::dhcpserver::pool[$index]:
          network => $::dhcpserver::network[$index],
          mask    => $::dhcpserver::mask[$index],
          range   => $::dhcpserver::range[$index],
          gateway => $::dhcpserver::gateway[$index]
        }
      } 
  }

}
