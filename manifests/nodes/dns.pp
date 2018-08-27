node 'dns.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor dns',
    application    => 'DNS Bind9',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
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
    allow_query        => ['10.2.1.0/24', '10.2.22.0/22', '10.2.24/24', '10.2.9/24', '10.2.128.0/24','200.14.49.0/27', '200.55.143.8/29', '152.207.173.40/29'],
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

