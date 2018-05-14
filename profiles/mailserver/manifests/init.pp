class mailserver {
  
  class { 'roundcube':
    imap_host   => 'ssl://localhost',
    imap_port   => 993,
    db_type     => 'pgsql',
    db_name     => 'roundcube',
    db_host     => 'localhost',
    db_username => 'roundcube',
    db_password => 'secret',
  }

}

