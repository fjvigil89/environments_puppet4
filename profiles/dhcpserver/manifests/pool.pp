#class dhcpserver::pool
# This class is meant to be called from dhcpserver
# It set variable according to platform
class dhcpserver::pool(){
  if($::dhcpserver::pool_enabled){
    each($::dhcpserver::pool) |Integer $index, String $value|{
        dhcp::pool{'${value}':
          network => $::dhcpserver::network[${value}],
          mask    => $::dhcpserver::mask[${value}],
          range   => $::dhcpserver::range[${value}],
          gateway => $::dhcpserver::gateway[${value}]
        }
      } 
  }

}
