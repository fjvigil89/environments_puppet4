class roles::email_roundcube {
   class {'roundcube':
      imap_host => 'ssl://localhost',
      imap_port => 993,
    }
}

