#class: basesys::puppet
# ===========================
#
# Agent configuration for our nodes 
#
# lint:ignore:80chars

class basesys::puppet{
  if($basesys::puppet_enabled) {
    cron::job { 'puppet_cron':
      ensure      => absent,
      minute      => '*/30',
      hour        => '*',
      date        => '*',
      month       => '*',
      weekday     => '*',
      user        => 'root',
      command     => '/opt/puppetlabs/bin/puppet agent --config /etc/puppetlabs/puppet/puppet.conf --onetime --no-daemonize',
      description => 'Puppet',
  }
  
    file {'/etc/puppetlabs/puppet/README' :
        ensure => present,
        source => 'puppet:///modules/basesys/README';
    }
    cron{'puppet_cheking':
      #ensure  => absent,
     command => '/opt/puppetlabs/bin/puppet agent --config /etc/puppetlabs/puppet/puppet.conf --onetime --no-daemonize',
     minute    => ['*/30'],
    }
  }
}
