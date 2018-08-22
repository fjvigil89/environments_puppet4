#class dhcpserver::params
# This class is meant to be called from basesys
# It set variable according to platform
class dhcpserver::params{
  #$service_ensure     => running
  
#basesys
 $dnsdomain          = [$::basesys::params::dnssearchdomains]
 $nameservers        = $::basesys::params::dnsservers
 $ntpservers         = $::basesys::params::ntp_server

#dhcp
 $interfaces         = ['eth0']
 $omapi_port         = 7911
 $default_lease_time = 600
 $max_lease_time     = 7200
 
#pool
 $pool_enabled = true
 $namepool  = ['identificadores']
 $networks  = ['0.0.0.0']
 $masks     = ['255.255.255.255']
 $ranges    = ['0.0.0.0 255.255.255.255']
 $gateways  = ['0.0.0.1']

#ignoredsubnet
 $ignoredsubnet_enabled               = false
 $ignoredsubnets                      = [undef]
 $ignoredsubnet_networks              = [undef]
 $ignoredsubnet_masks                 = [undef]

#host
 $host_enabled          = false
 $hosts                 = [undef]
 $comments              = [undef]
 $macs                  = [undef]
 $ips                   =  [undef]

 

}
