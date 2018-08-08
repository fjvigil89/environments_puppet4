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
    source => 'puppet:///modules/monitoring/mcheck/check_mem.pl',
  }


  # mysql_health 
  # https://wiki.ugent.be/display/SYSADMIN/mysql_health

  # Este archivo se generó al ejecutar configure y make.
  # El archivo generado ./plugins-scripts/check_mysql_health luego se convirtió aquí
  # incluido en Puppet.
  #file { "${plugin_dir}/check_mysql_health":
  #  ensure => file,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0755',
  #  source => 'puppet:///modules/monitoring/checks/check_mysql_health',
  #}

  # Laatste versie te vinden op https://github.com/mcrauwel/go-check-orchestrator/releases/latest/
  #file { "${plugin_dir}/check_orchestrator":
  #  ensure => file,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0755',
  #  source => 'puppet:///modules/monitoring/checks/check_orchestrator',
  #}

  # Laatste versie te vinden op https://github.com/aswen/nagios-plugins/blob/master/check_puppet_agent
  # Heeft sudo nodig
  #file { "${plugin_dir}/check_puppet_agent_2018":
  #  ensure => file,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0755',
  #  source => 'puppet:///modules/monitoring/checks/check_puppet_agent_2018',
  #}

  # https://www.thomas-krenn.com/en/wiki/IPMI_Sensor_Monitoring_Plugin
  #$ipc_run_package = $::osfamily ? {
  #  'RedHat' => 'perl-IPC-Run',
  #  default  => 'libipc-run-perl',
  #}

  #file { "${plugin_dir}/check_ipmi_sensor":
  #  ensure => file,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0755',
  #  source => 'puppet:///modules/monitoring/checks/check_ipmi_sensor',
  #}

  # installeer Nagios plugin check_pv
  #file { "${plugin_dir}/check_pv":
  #  ensure => file,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0755',
  #  source => 'puppet:///modules/monitoring/checks/check_pv',
  #}

  #file { "${plugin_dir}/spectre-meltdown-checker.sh":
  #  ensure => file,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0755',
  #  source => 'puppet:///modules/monitoring/checks/spectre-meltdown-checker.sh',
  #}

  #$packages = [ $ipc_run_package, ]
  #ensure_packages ($packages)

}

