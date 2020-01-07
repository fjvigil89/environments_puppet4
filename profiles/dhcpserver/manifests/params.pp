#class dhcpserver::params
# This class is meant to be called from basesys
# It set variable according to platform
class dhcpserver::params{
  #$service_ensure     => running
  
#basesys
 $dnsdomain          = [$::basesys::params::dnssearchdomains]
 $nameservers        = ['10.2.1.8','10.2.4.13']
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
 $ignoredsubnets                      = ['identificadores'] 
 $ignoredsubnet_networks              = ['0.0.0.0']
 $ignoredsubnet_masks                 = ['255.255.255.255']

#host
 $host_enabled          = false
 $hosts                 = ['0.0.0.0']
 $comments              = ['identificadores']
 $macs                  = ['00:50:56:00:00:01']
 $ips                   = ['10.0.1.51']

#pke
 $pxeserver   = "pke.upr.edu.cu"
 $pxefilename = "pxelinux.0"

}
