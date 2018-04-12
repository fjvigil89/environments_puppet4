node 'default'{
  include roles::file
}
node 'client-puppet.upr.edu.cu'{
  #include roles::file
  #include profile::emai
  class {'roundcube':
  imap_host =>  'ssl://localhost',
  imap_port =>  993,
  }

}
