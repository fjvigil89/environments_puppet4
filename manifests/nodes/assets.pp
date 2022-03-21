node /^assets\d+$/{
  package { 'lsb-release':
    ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor de Assets',
    application    => 'Proxmox BeKa',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
