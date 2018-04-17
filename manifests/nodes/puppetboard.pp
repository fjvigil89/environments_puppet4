node 'client-puppet.upr.edu.cu'{
  class {'::puppetboardserve':;}

  cron { 'logrotate':
    command =>  '/usr/sbin/logrotate',
    user =>  'root',
    minute =>  '*/10',
  }
}
