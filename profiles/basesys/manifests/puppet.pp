#class: basesys::puppet
# ===========================
#
# Agent configuratie voor onze nodes
#
# lint:ignore:80chars

class basesys::puppet{
  if($basesys::puppet_enabled) {
    
   #cron { 'puppet-basesys-run':
   #   ensure  => absent,
   # }
   
   #file { '/usr/local/sbin/enable-puppet':
   #     ensure => absent,
   # }
   
   #cron { 'enable-puppet':
   #   ensure  => absent,
   # }
   
   #file { '/usr/local/sbin/cron-puppet-noop':
   #   ensure => absent,
   # }
   
   #cron { 'puppet-noop-run':
   #   ensure  => absent,
   # }
  
  class { '::puppet':
      puppetmaster         => $basesys::puppetmaster,
     #autosign             => $basesys::params::autosign,
      manage_packages      => $basesys::params::manage_packages,
      runmode              => $basesys::params::runmode,
      version              => $basesys::params::puppet_version,
      unavailable_runmodes => ['systemd.timer'],
      environment          => $basesys::puppet_environment,
    }
    # Voor de network puppet module
    package { 'ipaddress':
      ensure   => installed,
      provider => 'puppet_gem',
      require  => Class['::puppet'];
    }
    # Verwijderen oude puppet config
    file {
      '/etc/puppet/puppet.conf':
        ensure => 'absent';
      '/etc/puppet/puppet.conf.pre_fcopy':
        ensure => 'absent';
      '/etc/puppet/etckeeper-commit-pre':
        ensure => 'absent';
      '/etc/puppet/etckeeper-commit-post':
        ensure => 'absent';
      '/etc/puppet/README':
        ensure => present,
        source => 'puppet:///modules/basesys/README';
    }
  }
}
