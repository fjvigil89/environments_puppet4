#class: monitoring::checks
# ===========================
#
# Install plugins for icinga2 agents
#
class monitoring::checks {
  $plugin_dir = $::osfamily ? {
    'RedHat' => '/usr/lib64/nagios/plugins',
    default  => '/usr/lib/nagios/plugins',
  }
  
  file { "${plugin_dir}/check_mem.pl":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_mem.pl',
  }
  
  file { "${plugin_dir}/check_apache_status.pl":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_apache_status.pl',
  }

  file { "${plugin_dir}/check_mailq":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_mailq',
  }
  
  file { "${plugin_dir}/check_snmp":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_snmp',
  }
  
  file { "${plugin_dir}/check_amavis.pl":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_amavis.pl',
  }
  
  file { "${plugin_dir}/check_rbl":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_rbl',
  }
  
  file { "${plugin_dir}/check_ceph.py":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_ceph.py',
  }
  
  file { "${plugin_dir}/check_iostats":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_iostats',
  }


}

