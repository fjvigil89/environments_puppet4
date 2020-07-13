# == Class basesys::params
# This class is meant to be called from basesys
# It set variable according to platform
class basesys::params {
  $pkgname = 'basesys'
  $conffile = 'basesys/etc/basesys.conf'
  
  # forward (10.2.1.8) upr
  $dnsservers = ['10.2.1.8'] #10.2.4.14
  $preinstall_dns = ['10.2.1.4','8.8.8.8']#
  $nsservers = ['200.14.49.2']#
  $dmzservers = ['10.2.1.4','200.14.49.2','8.8.8.8']#

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

  #Para servidores con IP Publico
  $dmz = false
  
  #repos 
  $repos = true
  $repo_url = 'repos.upr.edu.cu'
  
  #To manage Firewall
  $enable_firewall = false
  $upr_networks    = ['200.14.49.0/27', '200.55.143.8/29', '152.207.173.40/29','10.2.0.0/15','192.168.200.0/30']
  $open_ports      = ['22','123','111','659','5665','161','199','443','25']
  $proto_ports     = ['tcp','upd','tcp','udp','tcp','udp','tcp','tcp','tcp']

  # Puppet agent settings
  $puppet_enabled	    = true 
  $puppetmaster       = 'puppet-master.upr.edu.cu'
  $puppet_environment = 'production'
  $runmode            = 'cron'
  $manage_packages    = 'agent'
  $puppet_version	    = 'latest'
  $puppet_server 	    = true
  #$autosign              = '/etc/puppetlabs/code/environments/production/bin/autosign-dns'
  #$puppet_version        = $::osfamily ? {
  #  /Debian/ => "1.10.9-1${::lsbdistcodename}",
  #  /RedHat/ => '1.10.9',
  #  default  => 'latest'
  #}
  $puppet_users   = true

  $proxy_enabled = false
  $proxy_url     = 'http://servers-proxy.upr.edu.cu'
  $proxy_port    = '8080'
  $proxy_user    = ''
  $proxy_pass    = ''


}
