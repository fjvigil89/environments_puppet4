# Class: mysql_server::users
# ===========================
#
# Full description of class mysql_server here.
#
#
class mysql_server::users (
  String $orchestrator_topology_user = 'orchestrator',
  String $orchestrator_topology_pass = '',
  Array $orchestrator_topology_privileges = [],
  Array $orchestrator_hostnames = [],

  String $mysql_replication_user = 'replication',
  String $mysql_replication_pass = '',
  Array $mysql_replication_hosts = [],

  String $mysql_monitor_username = 'monitor',
  String $mysql_monitor_password = 'monitor',

  Hash $backend_users = {},
  Array $proxy_servers = [],
  Hash $mysql_grants = {},
) {
  # lint:ignore:140chars
  assert_private()

  $backend_user_default = {
    'ensure'   => 'present',
  }

  $mysql_grant_default = {
    'ensure'     => 'present',
    'database'   => '*',
    'tables'     => '*',
    'privileges' => ['NONE'],
    'options'    => [],
  }

  $orchestrator_hostnames.each |String$hostname| {
    mysql_user { "${orchestrator_topology_user}@${hostname}":
      ensure        => present,
      password_hash => mysql_password($orchestrator_topology_pass),
      require       => Class['::mysql::server::service'],
    }

    mysql_grant { "${orchestrator_topology_user}@${hostname}/*.*":
      ensure     => present,
      privileges => $orchestrator_topology_privileges,
      table      => '*.*',
      user       => "${orchestrator_topology_user}@${hostname}",
      require    => Class['::mysql::server::service'],
    }

    mysql_grant { "${orchestrator_topology_user}@${hostname}/mysql.*":
      ensure     => present,
      privileges => [ 'SELECT' ],
      table      => 'mysql.*',
      user       => "${orchestrator_topology_user}@${hostname}",
      require    => Class['::mysql::server::service'],
    }

  }

  $nagios_ips = concat([ '127.0.0.1' ], $basesys::params::nagiosips)
  $nagios_user = lookup('mysql_server::mysql_nagios_user', String, 'first', 'nagios')
  $nagios_pass = lookup('mysql_server::mysql_nagios_pass', String, 'first', 'nagios')
  $nagios_ips.each |String$nagios_ip| {
    if $nagios_ip != '' {
      mysql_user { "${nagios_user}@${nagios_ip}":
        ensure        => present,
        password_hash => mysql_password($nagios_pass),
        require       => Class['::mysql::server::service'],
      }

      mysql_grant { "${nagios_user}@${nagios_ip}/*.*":
        ensure     => present,
        privileges => [ 'REPLICATION CLIENT' ],
        table      => '*.*',
        user       => "${nagios_user}@${nagios_ip}",
        require    => Class['::mysql::server::service'],
      }
    }
  }

  $mysql_replication_hosts.each |String$hostname| {
    mysql_user { "${mysql_replication_user}@${hostname}":
      ensure        => present,
      password_hash => mysql_password($mysql_replication_pass),
      require       => Class['::mysql::server::service'],
    }

    mysql_grant { "${mysql_replication_user}@${hostname}/*.*":
      ensure     => present,
      privileges => [ 'REPLICATION SLAVE' ],
      table      => '*.*',
      user       => "${mysql_replication_user}@${hostname}",
      require    => Class['::mysql::server::service'],
    }

  }

  #lint:ignore:variable_scope
  $proxy_servers.each |String$hostname| {
    mysql_user { "${mysql_monitor_username}@${hostname}":
      ensure        => present,
      password_hash => mysql_password($mysql_monitor_password),
      require       => Class['::mysql::server::service'],
    }

    mysql_grant { "${mysql_monitor_username}@${hostname}/*.*":
      ensure     => present,
      privileges => [ 'REPLICATION CLIENT' ],
      table      => '*.*',
      user       => "${mysql_monitor_username}@${hostname}",
      require    => Class['::mysql::server::service'],
    }

    $backend_users.each |String$index, Hash$backend_user| {
      validate_hash($backend_user)

      $backend_user_merged = merge($backend_user_default, $backend_user)
      $username = assert_type(String[1], $backend_user_merged['username']) |$expected, $actual| {
        fail( "backend_user parameter username should not be empty, expected: '${expected}', actual: '${actual}'." )
      }
      $password = $backend_user_merged['password']

      mysql_user { "${username}@${hostname}":
        ensure        => $backend_user_merged['ensure'],
        password_hash => mysql_password($password),
        tag           => [ 'mysql_backend_user', $::mysql_server::cluster_name ],
        require       => Class['::mysql::server::service'],
      }
    }

    $mysql_grants.each |String$index, Hash$mysql_grant| {
      validate_hash($mysql_grant)

      $mysql_grant_merged = merge($mysql_grant_default, $mysql_grant)
      $username = assert_type(String[1], $mysql_grant_merged['user']) |$expected, $actual| {
        fail( "mysql_grant parameter user should not be empty, expected: '${expected}', actual: '${actual}'." )
      }
      $database = $mysql_grant_merged['database']
      $tables = $mysql_grant_merged['tables']

      mysql_grant { "${username}@${hostname}/${database}.${tables}":
        ensure     => $mysql_grant_merged['ensure'],
        privileges => $mysql_grant_merged['privileges'],
        options    => $mysql_grant_merged['options'],
        table      => "${database}.${tables}",
        user       => "${username}@${hostname}",
        require    => Class['::mysql::server::service'],
      }
    }
  }
  #lint:endignore

}
