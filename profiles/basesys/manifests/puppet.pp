#class: basesys::puppet
# ===========================
#
# Agent configuration for our nodes 
#
# lint:ignore:80chars

class basesys::puppet{
  if($basesys::puppet_enabled) {
  
    file {'/etc/puppetlabs/puppet/README' :
        ensure => present,
        source => 'puppet:///modules/basesys/README';
    }
    cron{'puppet_cheking':
     ensure  => absent,
     command => '/opt/puppetlabs/bin/puppet agent -t --environment=production --server=puppet-master.upr.edu.cu',
     minute    => ['*/30'],
    }
  }
}
