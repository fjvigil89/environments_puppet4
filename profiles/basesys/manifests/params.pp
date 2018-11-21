# == Class basesys::params
# This class is meant to be called from basesys
# It set variable according to platform
class basesys::params {
  $pkgname = 'basesys'
  $conffile = 'basesys/etc/basesys.conf'
  
  # DNS 10.2.1.13 forward internet another forward (10.2.1.8) upr
  $dnsservers = [ '10.2.1.8','10.2.1.13']

  # dominio
  $dnssearchdomains = 'upr.edu.cu'

  # NTP
  $ntp_server  	   = ['ntp0.upr.edu.cu','ntp1.upr.edu.cu','ntp2.upr.edu.cu','ntp3.upr.edu.cu']
  $ntp_server_upr  = ['0.north-america.pool.ntp.org','1.north-america.pool.ntp.org','2.north-america.pool.ntp.org','3.north-america.pool.ntp.org']
  $ntpconf         = 'ntp/ntp.conf.epp'


  # Postfix
  $mta_enabled		       = false
  $root_alias            = 'master@upr.edu.cu'
  $postmaster            = 'master@upr.edu.cu'
  $inet_interfaces       = 'loopback-only'
  $relayhost             = ''
  $mailname              = $::fqdn
  
  #monitoring
  $monitoring_enabled = true
  $graphite_host      = 'graphite.upr.edu.cu' 
  #Proxmox
  $proxmox_enabled    = false
  
  #repos 
  $repos = true

  # Puppet agent settings
  $puppet_enabled	 = true 
  $puppetmaster          = 'puppet-master.upr.edu.cu'
  $puppet_environment    = 'production'
  $runmode               = 'cron'
  $manage_packages       = 'agent'
  $puppet_version	 = 'latest'
  #$autosign              = '/etc/puppetlabs/code/environments/production/bin/autosign-dns'
  #$puppet_version        = $::osfamily ? {
  #  /Debian/ => "1.10.9-1${::lsbdistcodename}",
  #  /RedHat/ => '1.10.9',
  #  default  => 'latest'
  #}
  $puppet_users   = true 
}
