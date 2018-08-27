# == Class basesys::params
# This class is meant to be called from basesys
# It set variable according to platform
class basesys::params {
  $pkgname = 'basesys'
  $conffile = 'basesys/etc/basesys.conf'
  
  # DNS 10.2.1.13 forward internet another forward (10.2.1.8) upr
  $dnsservers = [ '10.2.1.14','10.2.1.13','10.2.1.15']

  # dominio
  $dnssearchdomains = 'upr.edu.cu'

  # NTP
  $ntp_server  = ['10.2.1.11','ntp.upr.edu.cu','time.upr.edu.cu']
  $ntpconf     = 'ntp/ntp.conf.epp'


  # Postfix
  $mta_enabled		 = false
  $root_alias            = 'master@upr.edu.cu'
  $postmaster            = 'master@upr.edu.cu'
  $inet_interfaces       = 'loopback-only'
  $relayhost             = ''
  $mailname              = $::fqdn
  
  #monitoring
  $monitoring_enabled = true

  #repos 
  $repos = true

  # Puppet agent settings
  $puppet_enabled	 = false 
  $puppetmaster          = 'puppet-master.upr.edu.cu'
  $puppet_environment    = 'production'
  $runmode               = 'cron'
  $manage_packages       = 'agent'
  #$autosign              = '/etc/puppetlabs/code/environments/production/bin/autosign-dns'
  $puppet_version        = $::osfamily ? {
    /Debian/ => "1.10.9-1${::lsbdistcodename}",
    /RedHat/ => '1.10.9',
    default  => 'latest'
  }

}
