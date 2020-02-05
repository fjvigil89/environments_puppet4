node 'ns1.upr.edu.cu'{
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor dns externo',
    application    => 'DNS Bind9',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
    dns_enabled    => false,
    
  }
}
node 'ns2.upr.edu.cu', 'ns3.upr.edu.cu'{
  package { 'lsb-release':
    ensure => installed,
    }~>
    class { '::basesys':
      uprinfo_usage  => 'servidor dns externo secundario',
      application    => 'DNS Bind9',
      puppet_enabled => false,
      repos_enabled  => true,
      mta_enabled    => false,
      dns_enabled    => false,
    }
  
  $zone    = 'type slave'
  $allow   = "{ any; }"
  $direct  = "/var/lib/bind"
  $masters = "{ 200.14.49.2; }"
  $quote   = '"'  
  class {'::dns_primary':
    config_file        => '/etc/bind/named.conf',
    directory          => '/etc/bind',
    dump_file          => 'cache_dump.db',
    statistics_file    => 'named_stats.txt',
    memstatistics_file => 'named_mem_stats.txt',
    slave              => true,
    allow_query        => $allow,
    recursion          => 'yes',
    zone_name          => [ 'upr.edu.cu'],
    zone_type          => $zone,
    mymaster           => $masters,
    file_zone_name     => [ 'db.upr.edu.cu', 'db.49.14.200', 'db.143.55.200', 'db.173.207.152'],
    zone_reverse       => [ '49.14.200.in-addr.arpa', '143.55.200.in-addr.arpa', '173.207.152.in-addr.arpa'],
    zones              => {
      'upr.edu.cu' => [
        $zone,
        "allow-query $allow",
        "masters $masters",
        "allow-notify $masters",
        "file ${quote}${direct}/db.upr.edu.cu${quote}",
      ],
      '27/0.49.14.200.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "masters $masters",
        "allow-notify $masters",
        "file ${quote}${direct}/db.49.14.200${quote}",
      ],
      '29/8.143.55.200.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "masters $masters",
        "allow-notify $masters",
        "file ${quote}${direct}/db.143.55.200${quote}",
        ],
        '29/40.173.207.152.in-addr.arpa' => [
          $zone,
          "allow-query $allow",
          "masters $masters",
          "allow-notify $masters",
          "file ${quote}${direct}/db.173.207.152${quote}",
          ],
    },
  }
}


