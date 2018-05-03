# == Class basesys::params
# This class is meant to be called from basesys
# It set variable according to platform
class basesys::params {
  $pkgname = 'basesys'
  $conffile = 'basesys/etc/basesys.conf'
  
  # DNS
  $dnsservers = [ '10.2.1.8','8.8.8.8']

  # dominio
  $dnssearchdomains = 'upr.edu.cu'

  # NTP
  $ntp_server  = ['10.2.1.11']
  $ntpconf     = 'ntp/ntp.conf.erb'


  # Puppet agent settings
  $puppet_enabled        = $::virtual ? {
    'virtualbox' => false,
    default      => true,
  }
  $puppetmaster          = 'puppet-master.upr.edu.cu'
  $puppet_environment    = 'production'
  $runmode               = 'cron'
  $manage_packages       = 'agent'
  #$autosign              = '/etc/puppetlabs/code/environments/production/bin/autosign-dns'
  #$puppet_version        = $::osfamily ? {
  #  /Debian/ => "1.10.9-1${::lsbdistcodename}",
  #  /RedHat/ => '1.10.9',
  #  default  => 'latest'
  #}
  $puppet_version = 'latest'

}
