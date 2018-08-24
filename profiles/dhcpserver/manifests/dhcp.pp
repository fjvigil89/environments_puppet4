#class dhcpserver::dhcp
# This class is meant to be called for dhcpserver
# It set variable according to platform
class dhcpserver::dhcp(){

 class { 'dhcp':
  service_ensure     => running, #$dhcpserver::service_ensure,
  dnsdomain          => $dhcpserver::dnsdomain,
  nameservers        => $dhcpserver::nameservers,
  ntpservers         => $dhcpserver::ntpservers,
  interfaces         => $dhcpserver::interfaces,
  omapi_port         => $dhcpserver::omapi_port,
  default_lease_time => $dhcpserver::default_lease_time,
  max_lease_time     => $dhcpserver::max_lease_time
} 

}
