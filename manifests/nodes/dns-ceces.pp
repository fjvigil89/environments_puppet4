node 'dns.ceces.upr.edu.cu' {
    class { '::basesys':
      uprinfo_usage  => 'servidor dns subdominio ceces',
      application    => 'DNS Bind9',
      puppet_enabled => true,
      repos_enabled  => false,
      mta_enabled    => false,
      dns_enabled    => false,
    }
}

