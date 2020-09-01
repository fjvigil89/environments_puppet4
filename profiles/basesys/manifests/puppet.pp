#class: basesys::puppet
# ===========================
#
# Agent configuration for our nodes 
#
# lint:ignore:80chars

class basesys::puppet{
  if($basesys::puppet_enabled) {
    cron::job { 'puppet_cron':
      minute      => '*/30',
      hour        => '*',
      date        => '*',
      month       => '*',
      weekday     => '*',
      user        => 'root',
      command     => '/opt/puppetlabs/bin/puppet agent -t --environment=production --server=puppet-master.upr.edu.cu',
      description => 'Puppet',
  }
  
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
