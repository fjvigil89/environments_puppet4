# Configure the MySQL backup
class mysql_server::backup(
  $backup_share = $::mysql_server::backup_share,
  $backup_mount = $::mysql_server::backup_mount,
  $backup_encryption_key = $::mysql_server::backup_encryption_key,
  $backup_key_file = '/root/.mysql_backup_key',

  ) {

  package { 'qpress':
    ensure => 'installed',
  }

  if $backup_share != '' {
    $ensure_share = $::mysql_server::enable_backup_share ? {
      true  => 'present',
      false => 'absent',
    }

    nshares::mount { $backup_mount:
      ensure         => $ensure_share,
      sharename      => $backup_share,
      client_options => 'defaults,tcp,vers=3,ro',
      subdir         => $mysql_server::cluster_name,
    }
  }

  $ensure_keyfile = $backup_encryption_key ? {
    ''      => 'absent',
    default => 'file',
  }


  if $backup_encryption_key != '' {
    exec { 'create-backup-encryption-key':
      command => "/bin/echo -n ${backup_encryption_key} > ${backup_key_file}",
      creates => $backup_key_file,
    }

    file { $backup_key_file:
      ensure => $ensure_keyfile,
      owner  => 'root',
      group  => 'root',
      mode   => '0400',
    }
  }

  file { '/usr/local/sbin/mysql_create_backup':
    ensure  => 'file',
    content => template('mysql_server/backup-script.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }

  $ensure_cron = $::mysql_server::backup_slave ? {
    true    => 'present',
    false   => 'absent',
    default => 'absent',
  }

  cron { "mysql-backup-job-${::hostname}":
    ensure  => $ensure_cron,
    command => '/usr/local/bin/cronic /usr/local/sbin/mysql_create_backup',
    user    => 'root',
    hour    => '5',
    minute  => fqdn_rand('15', $backup_encryption_key),
  }

  if $::mysql_server::backup_slave {
    logrotate::rule { 'mysql-backup-log':
      path         => '/var/log/mysql/backup.log',
      rotate       => 105, # 15 weeks * 7 days
      rotate_every => 'day',
      compress     => true,
    }
  }
}
