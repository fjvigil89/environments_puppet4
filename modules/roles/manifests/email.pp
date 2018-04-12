class roles::emailRoundcube {
   class {'roundcube':
      imap_host => 'ssl://localhost',
      imap_port => 993,
    }
}

