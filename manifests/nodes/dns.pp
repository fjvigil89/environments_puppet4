node 'dns.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor dns',
    application    => 'DNS Bind9',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }

}

node 'dns2.upr.edu.cu'{
 package { 'lsb-release':
          ensure => installed,
  }#~>
  #class { '::basesys':
  #  uprinfo_usage  => 'servidor dns secundario',
  #  application    => 'DNS Bind9',
  #  puppet_enabled => false,
  #  repos_enabled  => true,
  #  mta_enabled    => false,
  #}

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
  }
}

