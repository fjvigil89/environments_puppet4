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
  
 file { "${plugin_dir}/check_nginx_status.pl":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/monitoring/checks/check_nginx_status.pl',
 }


}

