# == Class: dhcpserver
#
# Full description of class dhcpserver here.
#
# === Copyright
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class dhcpserver (
  #String $service_ensure           = $::dhcpserver::params::service_ensure,
 
 Array[String] $dnsdomain         = $::dhcpserver::params::dnsdomain,
 Array[String] $nameservers       = $::dhcpserver::params::nameservers,
 Array[String] $ntpservers        = $::dhcpserver::params::ntpservers,
 Array[String] $interfaces        = $::dhcpserver::params::interfaces,
 
 $omapi_port                      = $::dhcpserver::params::omapi_port,
 $default_lease_time              = $::dhcpserver::params::default_lease_time,
 $max_lease_time                  = $::dhcpserver::params::max_lease_time,

 Boolean $pool_enabled            = $::dhcpserver::params::pool_enabled,
 Array[String] $pool              = $::dhcpserver::params::namepool,
 Array[String] $network           = $::dhcpserver::params::networks,
 Array[String] $mask              = $::dhcpserver::params::masks,
 Array[String] $range             = $::dhcpserver::params::ranges,
 Array[String] $gateway           = $::dhcpserver::params::gateways,

 # lint:ignore:80chars
 Boolean $ignoredsubnet_enabled   = $::dhcpserver::params::ignoredsubnet_enabled,
 Array[String] $ignoredsubnet     = $::dhcpserver::params::ignoredsubnets,
 Array[String] $ignoredsubnet_network           = $::dhcpserver::params::ignoredsubnet_networks,
 Array[String] $ignoredsubnet_mask              = $::dhcpserver::params::ignoredsubnet_masks,
 
 Boolean $host_enabled            = $::dhcpserver::params::host_enabled,
 Array[String] $host              = $::dhcpserver::params::hosts,
 Array[String] $comment           = $::dhcpserver::params::comments,
 Array[String] $mac               = $::dhcpserver::params::macs,
 Array[String] $ip                = $::dhcpserver::params::ips,

 # lint:endignore

)inherits ::dhcpserver::params {

 class {'::dhcpserver::dhcp':;}
 class {'::dhcpserver::pool':;}
 class {'::dhcpserver::ignoredsubnet':;}
 class {'::dhcpserver::host':;}

}
