# Class: mysql_server
# ===========================
#
# This class describes a single MySQL server in the UGent-domain.
# It manages the installation of the server and manages the configuration files
# It also manages the tooling around the setup.
#
class mysql_server (
  String $root_password = 'root',

  String $cluster_name = '',

  Hash $override_options = {},

  String $datadir_device = '',
  String $datadir_device_options = '_netdev,rw,nosuid,nodev,acl,user_xattr,nobarrier',
  String $datadir_filesystem = 'ext4',

  Enum['mysql', 'percona', 'mariadb'] $provider = 'percona',

  $mysql_server_package = undef,
  $mysql_client_package = undef,
  $xtrabackup_package = undef,
  $percona_toolkit_package = $::mysql_server::params::percona_toolkit_package,

  String $orchestrator_topology_user = $::mysql_server::params::orchestrator_topology_user,
  String $orchestrator_topology_pass = $::mysql_server::params::orchestrator_topology_pass,
  Array $orchestrator_topology_privileges = $::mysql_server::params::orchestrator_topology_privileges,
  Array $orchestrator_hostnames = $::mysql_server::params::orchestrator_hostnames,

  String $mysql_replication_user = $::mysql_server::params::mysql_replication_user,
  String $mysql_replication_pass = $::mysql_server::params::mysql_replication_pass,
  Array $mysql_replication_hosts = $::mysql_server::params::mysql_replication_hosts,
  Integer $mysql_replication_delay = $::mysql_server::params::mysql_replication_delay,

  Array $proxy_servers = $::mysql_server::params::proxy_servers,

  String $mysql_monitor_username = $::mysql_server::params::mysql_monitor_username,
  String $mysql_monitor_password = $::mysql_server::params::mysql_monitor_password,

  String $collectd_username = $::mysql_server::params::mysql_collectd_username,
  String $collectd_password = $::mysql_server::params::mysql_collectd_password,

  Hash $backend_users = $::mysql_server::params::backend_users,
  Hash $mysql_grants = $::mysql_server::params::mysql_grants,

  Boolean $backup_slave = false,
  Boolean $enable_backup_share = false,
  String $backup_share = '',
  String $backup_mount = "/srv/${backup_share}",
  String $backup_encryption_key = '',

  # Replication sync plugin staat standaard niet aan zodat we
  # mysql_server standalone kunnen gebruiken
  Boolean $enable_rpl_semi_sync_plugin = false,

) inherits ::mysql_server::params {

  # Add mysqldba account's
  Accounts::User<| tag == 'mysqldba' |>

  case $provider {
    'percona': {
      $configure_repo = true;
      if( $mysql_server_package == undef ) {
        $mysql_server_package_real = 'percona-server-server-5.7'
      } else {
        $mysql_server_package_real = $mysql_server_package
      }

      if( $mysql_client_package == undef ) {
        $mysql_client_package_real = 'percona-server-client-5.7'
      } else {
        $mysql_client_package_real = $mysql_client_package
      }

      if( $xtrabackup_package == undef ) {
        $xtrabackup_package_real = 'percona-xtrabackup-24'
      } else {
        $xtrabackup_package_real = $xtrabackup_package
      }
    }
    'mariadb': {
      $configure_repo = true;
      fail('MariaDB is not implemented yet in mysql_server')
    }
    default: {
      $configure_repo = false;

      if( $mysql_server_package == undef ) {
        $mysql_server_package_real = 'mysql-server'
      } else {
        $mysql_server_package_real = $mysql_server_package
      }

      if( $mysql_client_package == undef ) {
        $mysql_client_package_real = 'mysql-client'
      } else {
        $mysql_client_package_real = $mysql_client_package
      }

      if( $xtrabackup_package == undef ) {
        $xtrabackup_package_real = 'xtrabackup'
      } else {
        $xtrabackup_package_real = $xtrabackup_package
      }
    }
  }

  if($enable_rpl_semi_sync_plugin){
    $repl_semi_sync_plugin_ensure = present
    $repl_semi_sync_options = {
      'mysqld' => {
        'rpl_semi_sync_master_enabled' => '1',
        'rpl_semi_sync_master_timeout' => '1000', # 1 second
        'rpl_semi_sync_slave_enabled' => '1',
      },
    }
  }else{
    $repl_semi_sync_plugin_ensure = absent
    $repl_semi_sync_options = {}
  }

  package {
    'numactl':
      ensure => installed;
    'libjemalloc1':
      ensure => installed;
  }

  # Configure the required repo's
  if $configure_repo {
    include ::mysql_server::repo
    Class['::mysql_server::repo'] -> Class['mysql::server']
  }

  # install mysql client
  class {'::mysql::client':
    package_name => $mysql_client_package_real,
  }

  Exec['apt_update'] -> Package['mysql_client'] -> Package['mysql-server']

  $override_options_real = mysql_deepmerge(lookup('mysql_server::mysql_default_override_options', {
      value_type    => Hash,
      default_value => {},
    }), $repl_semi_sync_options, $override_options
  )

  if($root_password == 'root') {
    $root_password_real = lookup('mysql_server::root_password')
  } else {
    $root_password_real = $root_password
  }

  if $datadir_device != '' {
    mount { '/var/lib/mysql':
      ensure  => 'mounted',
      device  => $datadir_device,
      fstype  => $datadir_filesystem,
      options => $datadir_device_options,
      before  => Class['::mysql::server'],
    }
  }
  class { '::mysql::server':
    package_name            => $mysql_server_package_real,
    root_password           => $root_password_real,
    remove_default_accounts => true,
    override_options        => $override_options_real,
    require                 => [Package['mysql_client']],
  }

  mysql_plugin { 'rpl_semi_sync_master':
    ensure => $repl_semi_sync_plugin_ensure,
    soname => 'semisync_master.so',
  }

  mysql_plugin { 'rpl_semi_sync_slave':
    ensure => $repl_semi_sync_plugin_ensure,
    soname => 'semisync_slave.so',
  }

  # make sure percona toolkit and xtrabackup are present
  package { $percona_toolkit_package:
    ensure => latest,
  }

  package { $xtrabackup_package_real:
    ensure  => latest,
  }

  ::systemd::service_limits { 'mysql.service':
    limits => {
      'LimitNOFILE' => 65535,
      'LimitNPROC'  => 65535,
    },
  }

  if($::mysqld_readonly == 'OFF'){
    class { '::mysql_server::users':
      orchestrator_topology_user       => $orchestrator_topology_user,
      orchestrator_topology_pass       => $orchestrator_topology_pass,
      orchestrator_topology_privileges => $orchestrator_topology_privileges,
      orchestrator_hostnames           => $orchestrator_hostnames,

      mysql_replication_user           => $mysql_replication_user,
      mysql_replication_pass           => $mysql_replication_pass,
      mysql_replication_hosts          => $mysql_replication_hosts,

      proxy_servers                    => $proxy_servers,

      mysql_monitor_username           => $mysql_monitor_username,
      mysql_monitor_password           => $mysql_monitor_password,

      backend_users                    => $backend_users,
      mysql_grants                     => $mysql_grants,
    }
  }

  class { '::mysql_server::monitoring':
    collectd_username => $collectd_username,
    collectd_password => $collectd_password,
  }

  if (versioncmp($::facts['mysql_version'], '5.7.4') > 0) {
    $postrotate_cmd = '/usr/bin/mysqladmin flush-logs error'
  } else {
    $postrotate_cmd = '/usr/bin/mysqladmin flush-logs'
  }

  logrotate::rule { 'mysql-error-log':
    path         => '/var/log/mysql/error.log',
    rotate       => 5,
    rotate_every => 'week',
    postrotate   => $postrotate_cmd,
  }

  file { '/root/mysql_cluster_info.sql':
    ensure => 'absent',
  }

  file { '/tmp/mysql_cluster_info.sql':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template('mysql_server/cluster_info.sql.erb'),
    #notify  => Exec['load-cluster-info-info-mysql'],
  }

  #exec { 'load-cluster-info-info-mysql':
  #  command     => '/bin/cat /tmp/mysql_cluster_info.sql | mysql --defaults-file=/root/.my.cnf',
  #  refreshonly => true,
  #}

  file { '/usr/local/sbin/mysql_start_replication':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    content => template('mysql_server/start-replication-script.erb'),
  }

  include ::mysql_server::backup
}
