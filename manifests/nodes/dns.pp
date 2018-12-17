node 'dns.upr.edu.cu' {
    class { '::basesys':
      uprinfo_usage  => 'servidor dns interno',
      application    => 'DNS Bind9',
      puppet_enabled => true,
      repos_enabled  => true,
      mta_enabled    => false,
      dns_enabled    => false,
    }

  $zone    = 'type master'
  $allow   = "{ 10.2.0.0/15; 10.71.46.0/24; 20.0.0.0/24; 172.30.146.0/27; 192.168.25.0/24; 200.14.49.0/27; 200.55.143.8/29; 152.207.173.40/29;}"
  $notify  = "{ 10.2.1.14; 10.2.1.15; }"
  $direct  = "/var/lib/bind"
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
    recursion          => 'yes',
    zone_name          => [ 'upr.edu.cu', 'ceces.upr.edu.cu', 'progintec.upr.edu.cu', 'tele4.upr.edu.cu'],
    zone_type          => $zone,
    file_zone_name     => [ 'db.upr.edu.cu', 'db.1.2.10', 'db.22.2.10', 'db.24.2.10'],
    zone_reverse       => [ '1.2.10.in-addr.arpa', '22.2.10.in-addr.arpa', '24.2.10.in-addr.arpa'],
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
        'type slave',
        "masters { 10.2.1.8; }",
        "allow-query $allow",
        "file ${quote}${direct}/db.ceces.upr.edu.cu${quote}",
      ],
      'progintec.upr.edu.cu' => [
        'type slave',
        "allow-query $allow",
        "masters { 10.2.24.158; }",
        "file ${quote}${direct}/db.progintec.upr.edu.cu${quote}",
      ],
      #'tele4.upr.edu.cu' => [
      #  'type slave',
      #  "allow-query $allow",
      #  "masters { 10.2.24.158; };",
      #  "file ${quote}${direct}/db.tele4.upr.edu.cu${quote}",
      #],
      '1.2.10.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "allow-update ${notify}",
        "also-notify ${notify}",
        "notify yes",
        "file ${quote}${direct}/db.1.2.10${quote}",
      ],
      '8.2.10.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "allow-update ${notify}",
        "also-notify ${notify}",
        "notify yes",
        "file ${quote}${direct}/db.8.2.10${quote}",
      ],
      '22.2.10.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "allow-update ${notify}",
        "also-notify ${notify}",
        "notify yes",
        "file ${quote}${direct}/db.22.2.10${quote}",
        ],
        '24.2.10.in-addr.arpa' => [
          $zone,
          "allow-query $allow",
          "allow-update ${notify}",
          "also-notify ${notify}",
          "notify yes",
          "file ${quote}${direct}/db.24.2.10${quote}",
          ],
    },
  }
}

## dns cache solo para la upr con forwarding 10.2.1.8
node 'dns-cache1.upr.edu.cu','dns-cache2.upr.edu.cu'{
 class {'::dns_secundary':
   config_file        => '/etc/bind/named.conf',
   directory          => '/etc/bind',
   dump_file          => 'cache_dump.db',
   statistics_file    => 'named_stats.txt',
   memstatistics_file => 'named_mem_stats.txt',
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
    allow_query        => ['10.2.1.0/24', '10.2.22.0/22', '10.2.24.0/22', '10.2.9.0/24', '10.2.68.128/25', '10.2.30.0/24', '10.2.128.0/24', '10.2.14.1/29' ,
    '10.2.72.0/24', '10.3.0.0/22', '10.2.63.0/24', '200.14.49.0/27', '200.55.143.8/29', '152.207.173.40/29'],
  }

}

