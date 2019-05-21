node 'puppet-test1.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage   => 'servidor test',
    application     => 'puppet',
    enable_firewall => true,
  }
}
node 'puppet-test.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
  }
  $zone    = 'type master'
  $allow   = "{ 10.2.0.0/15; 10.71.46.0/24; 20.0.0.0/24; 172.30.146.0/27; 192.168.25.0/24; 200.14.49.0/27; 200.55.143.8/29;}"
  $notify  = "{ 10.2.1.14; 10.2.1.15; }"
  $direct  = "/var/lib/bind"
  $quote   = '"'
  include git
  class { '::dns_primary':
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
    file_zone_name     => [ 'db.upr.edu.cu', 'db.1.2.10', 'db.3.2.10','db.4.2.10' ,'db.8.2.10'],
    zone_reverse       => [ '1.2.10.in-addr.arpa', '2.2.10.in-addr.arpa', '3.2.10.in-addr.arpa', '4.2.10.in-addr.arpa'],
    views              => {
      'internal' => {
        'match-clients' => ['10.2.0.0/15','200.14.49.0/27','200.55.143.8/29','10.71.46.0/24','172.30.146.0/27','192.168.25.0/24','20.0.0.0/24' ],
        'zones'            => {
          'upr.edu.cu' => [
            $zone,
            "allow-query $allow",
            "allow-update ${notify}",
            "also-notify ${notify}",
            "notify yes",
            "file ${quote}${direct}/db.upr.edu.cu${quote}",
          ],
          'progintec.upr.edu.cu' => [
            'type slave',
            "allow-query $allow",
            "masters { 10.2.4.158; }",
            "file ${quote}${direct}/db.progintec.upr.edu.cu${quote}",
          ],
          #'tele4.upr.edu.cu' => [
          #  'type slave',
          #  "allow-query $allow",
          #  "masters { 10.2.24.158; };",
          #  "file ${quote}${direct}/db.tele4.upr.edu.cu${quote}",
          #],
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
      },
        'external'         => {
          'match-clients' => [ 'any' ],
          'zones' => {
            'upr.edu.cu' => [
              $zone,
              "allow-query $allow",
              "allow-update ${notify}",
              "also-notify ${notify}",
              "notify yes",
              "file ${quote}${direct}/db.upr.edu.cu.external${quote}",
            ],
          },
        },
    },
  }
}
