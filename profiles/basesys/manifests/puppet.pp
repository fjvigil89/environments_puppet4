#class: basesys::puppet
# ===========================
#
# Agent configuration for our nodes 
#
# lint:ignore:80chars

class basesys::puppet{
  if($basesys::puppet_enabled) {
  
  cron { 'puppet-basesys-run':
    ensure  => absent,
  }
  
  file { '/usr/local/sbin/enable-puppet':
    ensure => absent,
  }
  cron { 'enable-puppet':
    ensure  => absent,
  }
  file { '/usr/local/sbin/cron-puppet-noop':
    ensure => absent,
  }
  cron { 'puppet-noop-run':
    ensure  => absent,
  }
  
  class { '::puppet':
      puppetmaster         => $basesys::puppetmaster,
      manage_packages      => $basesys::params::manage_packages,
      runmode              => $basesys::params::runmode,
      version              => $basesys::params::puppet_version,
      unavailable_runmodes => ['systemd.timer'],
      environment          => $basesys::puppet_environment,
    }
    # For the network puppet module
    #package { 'ipaddress':
    #  ensure   => installed,
    #  provider => 'puppet_gem',
    #  require  => Class['::puppet'];
    #}
    # copy Readme puppet config
    file {
      #'/etc/puppetlabs/puppet/puppet.conf':
      #  ensure => 'absent';
      #'/etc/puppetlabs/puppet/puppet.conf.pre_fcopy':
      #  ensure => 'absent';
      #'/etc/puppetlabs/puppet/etckeeper-commit-pre':
      #  ensure => 'absent';
      #'/etc/puppetlabs/puppet/etckeeper-commit-post':
      #  ensure => 'absent';
      '/etc/puppetlabs/puppet/README':
        ensure => present,
        source => 'puppet:///modules/basesys/README';
    }

    cron{'puppet_cheking':
     ensure  => present,
     command => '/opt/puppetlabs/bin/puppet agent -t --environment=production --server=puppet-master.upr.edu.cu',
     minute    => ['*/30'],
    }
  }
}
