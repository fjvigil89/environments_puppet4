node 'dns.upr.edu.cu'{
    class { '::basesys':
      uprinfo_usage   => 'servidor dns interno',
      application     => 'DNS Bind9',
      puppet_enabled  => true,
      repos_enabled   => false,
      mta_enabled     => false,
      dns_enabled     => false,
    }
    #class {'::gitlab_runner':;}

  $zone    = 'type master'
  $allow   = "{ 10.2.0.0/15; 10.71.46.0/24; 20.0.0.0/24; 172.30.146.0/27; 192.168.25.0/24; 200.14.49.0/27; 200.55.143.8/29; 152.207.173.40/29;}"
  $notify  = "{ 10.2.1.8;}"
  $direct  = "/var/lib/bind/zone"
  $quote   = '"'
  include git
  class {'::dns_primary':
    config_file        => '/etc/bind/named.conf',
    directory          => '/etc/bind',
    dump_file          => 'cache_dump.db',
    statistics_file    => 'named_stats.txt',
    memstatistics_file => 'named_mem_stats.txt',
    slave              => false,
    allow_query        => $allow_q,
    recursion          => 'no',
    allow_recursion    => [ '10.2.9.0/27'],
    zone_name          => [ 'upr.edu.cu', 'ceces.upr.edu.cu'],
    zone_type          => $zone,
    file_zone_name     => [ 'db.upr.edu.cu', 'db.1.2.10', 'db.3.2.10','db.4.2.10' ,'db.8.2.10'],
    zone_reverse       => [ '1.2.10.in-addr.arpa', '2.2.10.in-addr.arpa', '3.2.10.in-addr.arpa', '4.2.10.in-addr.arpa'],
    zones              => {
      'upr.edu.cu' => [
        $zone,
        "allow-query $allow",
        "allow-update ${notify}",
        "also-notify ${notify}",
        "notify yes",
        "file ${quote}${direct}/db.upr.edu.cu${quote}",
      ],
      'ceces.upr.edu.cu' => [
        $zone,
        #"masters { 10.2.1.8; }",
        "allow-update ${notify}",
        "also-notify ${notify}",
        "allow-query $allow",
        "notify yes",
        "file ${quote}${direct}/db.ceces.upr.edu.cu${quote}",
      ],
      '2.2.10.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "allow-update ${notify}",
        "also-notify ${notify}",
        "notify yes",
        "file ${quote}${direct}/db.2.2.10${quote}",
        ],
        '3.2.10.in-addr.arpa' => [
          $zone,
          "allow-query $allow",
          "allow-update ${notify}",
          "also-notify ${notify}",
          "notify yes",
          "file ${quote}${direct}/db.3.2.10${quote}",
        ],
        '4.2.10.in-addr.arpa' => [
          $zone,
          "allow-query $allow",
          "allow-update ${notify}",
          "also-notify ${notify}",
          "notify yes",
          "file ${quote}${direct}/db.4.2.10${quote}",
        ],
        '1.2.10.in-addr.arpa' => [
          $zone,
          "allow-query $allow",
          "allow-update ${notify}",
          "also-notify ${notify}",
          "notify yes",
          "file ${quote}${direct}/db.1.2.10${quote}",
        ],
    },
  }
  #logrotate conf
  class { '::logrotate':
  ensure => 'latest',
  config => {
    dateext      => true,
    compress     => true,
    rotate       => 1,
    rotate_every => 'day',
    ifempty      => true,
  }
  }
  logrotate::rule { 'syslog':
    path         => '/var/log/syslog*.log',
    rotate       => 1,
    rotate_every => 'day',
    compress     => true,
    postrotate   => 'rm -f /var/log/syslog-*',
  }
  logrotate::rule { 'daemon':
    path         => '/var/log/daemon*.log',
    rotate       => 1,
    rotate_every => 'day',
    compress     => true,
    postrotate   => 'rm -f /var/log/daemon.log-*',
  }
}

## dns cache solo para la upr con forwarding
node 'dns-cache1.upr.edu.cu'{
 class {'::dns_secundary':
   config_file        => '/etc/bind/named.conf',
   directory          => '/etc/bind',
   dump_file          => 'cache_dump.db',
   statistics_file    => 'named_stats.txt',
   memstatistics_file => 'named_mem_stats.txt',
   forwarders         => ['10.2.1.4'],
   forward            => true,
   }
}

## dns cache de internet para la upr 
node 'dns-cache0.upr.edu.cu'{
  class {'::dns_secundary':
    config_file        => '/etc/bind/named.conf',
    directory          => '/etc/bind',
    dump_file          => 'cache_dump.db',
    statistics_file    => 'named_stats.txt',
    memstatistics_file => 'named_mem_stats.txt',
    forward            => true,
    forwarders         => ['8.8.8.8','8.8.4.4'],
    allow_query        => ['10.2.1.0/24', '10.2.2.0/21','10.2.9.0/27','10.2.14.1/29', '10.2.72.0/24', '10.2.63.0/24', 
    '200.14.49.0/27', '200.55.143.8/29','10.2.136.0/29'],
  }
}

