# Class: mysql_server::monitoring
# ===========================
#
# This class configures the monitoring for a MySQL server.
#
class mysql_server::monitoring (
  String $collectd_username = $::mysql_server::collectd_username,
  String $collectd_password = $::mysql_server::collectd_password,
) {
  # lint:ignore:140chars
  if(defined(Class['collectd'])) {

    package { 'python-mysqldb':
      ensure => installed,
    }

    mysql_user{ "${collectd_username}@127.0.0.1":
      ensure        => present,
      password_hash => mysql_password($collectd_password),
      require       => Class['::mysql::server::service'],
    }

    mysql_grant{ "${collectd_username}@127.0.0.1/*.*":
      ensure     => present,
      privileges => [ 'PROCESS', 'REPLICATION CLIENT' ],
      table      => '*.*',
      user       => "${collectd_username}@127.0.0.1",
      require    => Class['::mysql::server::service'],
    }

    class { '::collectd::plugin::python':
      modules => {
        'mysql' => {
          'script_source' => 'puppet:///modules/mysql_server/collectd-mysql.py',
          'config'        => [{
            'Host'     => '127.0.0.1',
            'Port'     => '3306',
            'User'     => $collectd_username,
            'Password' => $collectd_password,
            'Verbose'  => false,
          },],
        },
      },
    }
  }


  if(defined(Class['nrpe'])) {
    $nagios_user = lookup('mysql_server::mysql_nagios_user', String, 'first', 'nagios')
    $nagios_pass = lookup('mysql_server::mysql_nagios_pass', String, 'first', 'nagios')
    file { '/etc/nagios/mysql.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "user = ${nagios_user}
password = ${nagios_pass}
host = 127.0.0.1
",
  }

    file { 'check_mysql_slave':
      ensure => file,
      path   => "${nrpe::params::libdir}/check_mysql_slave",
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///modules/mysql_server/check_mysql_slave',
    }

    file { 'check_mysql_config':
      ensure => file,
      path   => "${nrpe::params::libdir}/check_mysql_config",
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///modules/mysql_server/check_mysql_config.bash',
    }

    nrpe::command { 'check_mysql_config':
      ensure  => 'present',
      command => 'check_mysql_config',
    }
  }
# lint:endignore
}
