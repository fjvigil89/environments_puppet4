# Class: basesys::paths
# ===========================
#
# paths configuratie.  paths
#
class basesys::paths{

  file { '/var/log/messages':
      group => 'adm';
  }

# Is dit nog nodig?
# Er is hier nog geen rspec test van
#  file {
#    '/etc/ssl/certs/UGent.pem':
#      owner  => 'root',
#      group  => 'root',
#      source => 'puppet:///modules/basesys/UGent.pem',
#  }

  $group_perm = $::operatingsystem ? {
    'Solaris' => 'root',
    'Debian'  => 'staff',
    default   => 'root'
  }

  $mode_perm  = $::operatingsystem ? {
    'Debian'  => '2775',
    default   => '0755'
  }

  file { '/usr/local':
      ensure => directory,
      owner  => 'root',
      group  => $group_perm,
      mode   => '0755';
  }

  file { '/usr/local/bin':
      ensure => directory,
      owner  => 'root',
      group  => $group_perm,
      mode   => $mode_perm;
  }

  file { '/usr/local/sbin':
      ensure => directory,
      owner  => 'root',
      group  => $group_perm,
      mode   => $mode_perm;
  }

  file { '/root':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0700',
  }

  file { '/etc/facter':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
  }

  file { '/etc/facter/facts.d':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
  }

  file { '/etc/facter/facts.d/application_tier.txt':
      ensure  => file,
      content => inline_template('application_tier=<%= scope.lookupvar("basesys::application_tier") %>'),
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
  }

  file { '/etc/facter/facts.d/application.txt':
      ensure  => file,
      content => inline_template('application=<%= scope.lookupvar("basesys::application") %>'),
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
  }

}
