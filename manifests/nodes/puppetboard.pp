node 'client-puppet.upr.edu.cu'{
  # class {'::puppetboardserve':;}

  cron { 'prueba':
    command =>  '/usr/sbin/logrotate',
    user =>  'root',
    minute =>  '*/10',
  }
}
