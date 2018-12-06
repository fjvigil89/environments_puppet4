node 'dns.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor dns',
    application    => 'DNS Bind9',
    dns_enabled    => false,
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
  $direct  = "/etc/bind/zone"
  $masters = "{ 200.14.49.2; }"
  
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
        "file ${direct}/db.upr.edu.cu",
      ],
      '27/0.49.14.200.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "masters $masters",
        "file ${direct}/db.49.14.200",
      ],
      '29/8.143.55.200.in-addr.arpa' => [
        $zone,
        "allow-query $allow",
        "masters $masters",
        "file ${direct}/db.143.55.200",
        ],
        '29/40.173.207.152.in-addr.arpa' => [
          $zone,
          "allow-query $allow",
          "masters $masters",
          "file ${direct}/db.173.207.152",
          ],
    },
  }
}


